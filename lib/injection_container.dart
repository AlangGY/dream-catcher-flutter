import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dream_catcher/core/network/network_info.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_data_source.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_mock_data_source.dart';
import 'package:dream_catcher/features/dream/data/repositories/dream_repository_impl.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/delete_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_date.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_mood.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/save_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/search_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/update_dream.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}

/// 2. 코어 유틸리티 초기화
void _initCore() {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl<Connectivity>(),
      internetConnectionChecker: sl<InternetConnectionChecker>(),
    ),
  );
}

/// 3. 데이터 소스 초기화
Future<void> _initDataSources() async {
  final dataSource = DreamMockDataSource();
  await dataSource.init();
  sl.registerLazySingleton<DreamDataSource>(
    () => dataSource,
  );
}

/// 4. 레포지토리 초기화
void _initRepositories() {
  sl.registerLazySingleton<DreamRepository>(
    () => DreamRepositoryImpl(
      dataSource: sl<DreamDataSource>(),
    ),
  );
}

/// 5. 유스케이스 초기화
void _initUseCases() {
  sl.registerLazySingleton(() => GetDreams(sl<DreamRepository>()));
  sl.registerLazySingleton(() => SaveDream(sl<DreamRepository>()));
  sl.registerLazySingleton(() => UpdateDream(sl<DreamRepository>()));
  sl.registerLazySingleton(() => DeleteDream(sl<DreamRepository>()));
  sl.registerLazySingleton(() => SearchDreams(sl<DreamRepository>()));
  sl.registerLazySingleton(() => FilterDreamsByMood(sl<DreamRepository>()));
  sl.registerLazySingleton(() => FilterDreamsByDate(sl<DreamRepository>()));
}

/// 6. Bloc 초기화
void _initBloc() {
  sl.registerFactory(
    () => DreamListBloc(
      getDreams: sl<GetDreams>(),
      saveDream: sl<SaveDream>(),
      updateDream: sl<UpdateDream>(),
      deleteDream: sl<DeleteDream>(),
      searchDreams: sl<SearchDreams>(),
      filterDreamsByMood: sl<FilterDreamsByMood>(),
      filterDreamsByDate: sl<FilterDreamsByDate>(),
    ),
  );
}
