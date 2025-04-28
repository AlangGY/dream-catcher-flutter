import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dream_catcher/core/network/network_info.dart';
import 'package:dream_catcher/core/webrtc/index.dart';
import 'package:dream_catcher/core/webrtc/openai_realtime_api_service.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_data_source.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_interview_data_source.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_interview_mock_data_source.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_remote_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_detail_model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_model.dart';
import 'package:dream_catcher/features/dream/data/repositories/dream_interview_repository_impl.dart';
import 'package:dream_catcher/features/dream/data/repositories/dream_repository_impl.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_interview_repository.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/delete_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_date.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_mood.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/add_message.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/complete_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/convert_voice_to_text.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/get_bot_response.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/get_current_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/start_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/save_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/search_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/update_dream.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_detail_bloc.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_interview_bloc.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_list_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:webrtc_interface/webrtc_interface.dart' show Navigator;

/// Service Locator
final GetIt sl = GetIt.instance;

Future<void> init() async {
  await _initExternalDependencies();

  // 코어 유틸리티
  _initCore();

  // 데이터 소스
  await _initDataSources();

  // 레포지토리
  _initRepositories();

  // 유스케이스
  _initUseCases();

  // Bloc
  _initBloc();
}

/// 1. 외부 라이브러리 의존성 초기화
Future<void> _initExternalDependencies() async {
  // 이미 생성된 SharedPreferences 인스턴스 등록
  // SharedPreferences 인스턴스를 직접 생성 (비동기)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<Uuid>(() => const Uuid());
}

/// 2. 코어 유틸리티 초기화
void _initCore() {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl<Connectivity>(),
      internetConnectionChecker: sl<InternetConnectionChecker>(),
    ),
  );

  // WebRTC 관련 서비스 등록
  _initWebRtcServices();
}

/// WebRTC 서비스 초기화
void _initWebRtcServices() async {
  sl.registerLazySingleton<MediaDevices>(() => MediaDevices());
  final configuration = <String, dynamic>{
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
    ],
  };
  final peerConnection = await createPeerConnection(configuration);

  sl.registerLazySingleton<RTCPeerConnection>(() => peerConnection);

  // OpenAI WebRTC 클라이언트 등록
  sl.registerFactory<WebRtcClient>(
    () => OpenAIWebRtcClient(
      enableLogging: true,
      peerConnection: sl<RTCPeerConnection>(),
      navigator: sl<Navigator>(),
      apiService: sl<OpenAIRealtimeApiService>(),
    ),
  );

  // WebRTC 서비스 등록
  sl.registerLazySingleton<WebRtcService>(
    () => WebRtcService(
      client: sl<WebRtcClient>(),
    ),
  );

  // OpenAI Realtime API 서비스 등록
  sl.registerFactory<OpenAIRealtimeApiService>(
    () => OpenAIRealtimeApiService(
      apiKey: const String.fromEnvironment('OPENAI_API_KEY',
          defaultValue: '<YOUR_API_KEY>'),
      model: 'gpt-4o',
    ),
  );
}

/// 3. 데이터 소스 초기화
Future<void> _initDataSources() async {
  // Dream 데이터 소스
  final dreamDataSource = DreamRemoteDataSource(
    client: sl<http.Client>(),
    baseUrl: 'http://localhost:3000',
    dreamListModelFactory: const DreamListModelFactory(),
    dreamDetailModelFactory: const DreamDetailModelFactory(),
  );
  sl.registerLazySingleton<DreamDataSource>(
    () => dreamDataSource,
  );

  // DreamInterview 데이터 소스
  sl.registerLazySingleton<DreamInterviewDataSource>(
    () => DreamInterviewMockDataSource(uuid: sl<Uuid>()),
  );
}

/// 4. 레포지토리 초기화
void _initRepositories() {
  // Dream 레포지토리
  sl.registerLazySingleton<DreamRepository>(
    () => DreamRepositoryImpl(
      dataSource: sl<DreamDataSource>(),
    ),
  );

  // DreamInterview 레포지토리
  sl.registerLazySingleton<DreamInterviewRepository>(
    () => DreamInterviewRepositoryImpl(
      dataSource: sl<DreamInterviewDataSource>(),
    ),
  );
}

/// 5. 유스케이스 초기화
void _initUseCases() {
  // Dream 유스케이스
  sl.registerLazySingleton(() => GetDream(sl<DreamRepository>()));
  sl.registerLazySingleton(() => GetDreams(sl<DreamRepository>()));
  sl.registerLazySingleton(() => SaveDream(sl<DreamRepository>()));
  sl.registerLazySingleton(() => UpdateDream(sl<DreamRepository>()));
  sl.registerLazySingleton(() => DeleteDream(sl<DreamRepository>()));
  sl.registerLazySingleton(() => SearchDreams(sl<DreamRepository>()));
  sl.registerLazySingleton(() => FilterDreamsByMood(sl<DreamRepository>()));
  sl.registerLazySingleton(() => FilterDreamsByDate(sl<DreamRepository>()));

  // DreamInterview 유스케이스
  sl.registerLazySingleton(
      () => StartInterview(sl<DreamInterviewRepository>()));
  sl.registerLazySingleton(() => AddMessage(sl<DreamInterviewRepository>()));
  sl.registerLazySingleton(
      () => GetBotResponse(sl<DreamInterviewRepository>()));
  sl.registerLazySingleton(
      () => CompleteInterview(sl<DreamInterviewRepository>()));
  sl.registerLazySingleton(
      () => ConvertVoiceToText(sl<DreamInterviewRepository>()));
  sl.registerLazySingleton(
      () => GetCurrentInterview(sl<DreamInterviewRepository>()));
}

/// 6. Bloc 초기화
void _initBloc() {
  // Bloc 인스턴스
  sl.registerFactory(() => DreamDetailBloc(getDream: sl<GetDream>()));

  // DreamListBloc 등록
  sl.registerFactory(
    () => DreamListBloc(
      getDreams: sl<GetDreams>(),
      deleteDream: sl<DeleteDream>(),
      searchDreams: sl<SearchDreams>(),
      filterDreamsByMood: sl<FilterDreamsByMood>(),
      filterDreamsByDate: sl<FilterDreamsByDate>(),
    ),
  );

  // DreamInterviewBloc 등록
  sl.registerFactory(
    () => DreamInterviewBloc(
      startInterview: sl<StartInterview>(),
      addMessage: sl<AddMessage>(),
      getBotResponse: sl<GetBotResponse>(),
      completeInterview: sl<CompleteInterview>(),
      convertVoiceToText: sl<ConvertVoiceToText>(),
      getCurrentInterview: sl<GetCurrentInterview>(),
    ),
  );
}
