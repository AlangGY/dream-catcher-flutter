import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/add_message.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/complete_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/convert_voice_to_text.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/get_bot_response.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/get_current_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/start_interview.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_interview_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<StartInterview>(),
  MockSpec<AddMessage>(),
  MockSpec<GetBotResponse>(),
  MockSpec<CompleteInterview>(),
  MockSpec<ConvertVoiceToText>(),
  MockSpec<GetCurrentInterview>(),
])
import 'dream_interview_bloc_test.mocks.dart';

void main() {
  late MockStartInterview mockStartInterview;
  late MockAddMessage mockAddMessage;
  late MockGetBotResponse mockGetBotResponse;
  late MockCompleteInterview mockCompleteInterview;
  late MockConvertVoiceToText mockConvertVoiceToText;
  late MockGetCurrentInterview mockGetCurrentInterview;
  late DreamInterviewBloc bloc;

  setUp(() {
    mockStartInterview = MockStartInterview();
    mockAddMessage = MockAddMessage();
    mockGetBotResponse = MockGetBotResponse();
    mockCompleteInterview = MockCompleteInterview();
    mockConvertVoiceToText = MockConvertVoiceToText();
    mockGetCurrentInterview = MockGetCurrentInterview();

    bloc = DreamInterviewBloc(
      startInterview: mockStartInterview,
      addMessage: mockAddMessage,
      getBotResponse: mockGetBotResponse,
      completeInterview: mockCompleteInterview,
      convertVoiceToText: mockConvertVoiceToText,
      getCurrentInterview: mockGetCurrentInterview,
    );
  });

  // 테스트용 인터뷰 데이터
  const tInterviewId = 'interview001';
  final tMessage = DreamInterviewMessage(
    id: 'message001',
    speakerType: SpeakerType.me,
    content: '안녕하세요',
    timestamp: DateTime(2024, 1, 1),
  );
  final tBotMessage = DreamInterviewMessage(
    id: 'message002',
    speakerType: SpeakerType.bot,
    content: '안녕하세요, 무엇을 도와드릴까요?',
    timestamp: DateTime(2024, 1, 1, 0, 0, 1),
  );
  final tInterview = DreamInterview(
    id: tInterviewId,
    messages: [tMessage, tBotMessage],
    date: DateTime(2024, 1, 1),
  );

  // 음성 데이터
  final tAudioData = [1, 2, 3, 4, 5];
  const tVoiceText = '저는 어젯밤에 바다에서 수영하는 꿈을 꾸었어요';

  void _setupFromStartInterview() {
    when(mockStartInterview()).thenAnswer((_) async => Right(tInterview));
    bloc.add(const StartInterviewEvent());
  }

  group('StartInterviewEvent', () {
    test('초기 상태는 DreamInterviewInitial이어야 함', () {
      expect(bloc.state, isA<DreamInterviewInitial>());
    });

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '인터뷰 시작이 성공적으로 처리되면 DreamInterviewLoaded 상태로 전환',
      build: () {
        when(mockStartInterview()).thenAnswer((_) async => Right(tInterview));
        return bloc;
      },
      act: (bloc) => bloc.add(const StartInterviewEvent()),
      expect: () => [
        isA<InitialLoadingState>(),
        isA<DreamInterviewLoaded>().having(
          (state) => state.interview,
          'interview',
          tInterview,
        ),
      ],
      verify: (_) {
        verify(mockStartInterview()).called(1);
      },
    );

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '인터뷰 시작 중 오류 발생 시 DreamInterviewError 상태로 전환',
      build: () {
        when(mockStartInterview()).thenAnswer(
          (_) async => const Left(ServerFailure(message: '서버 오류')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const StartInterviewEvent()),
      expect: () => [
        isA<InitialLoadingState>(),
        isA<DreamInterviewError>().having(
          (state) => state.message,
          'error message',
          '서버 오류',
        ),
      ],
      verify: (_) {
        verify(mockStartInterview()).called(1);
      },
    );
  });

  group('AddMessageEvent', () {
    const tContent = '안녕하세요';
    const tSpeakerType = SpeakerType.me;

    setUp(() {
      _setupFromStartInterview();
    });

    final tNewInterview = tInterview.copyWith(
      messages: [...tInterview.messages, tMessage],
    );
    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '메시지 추가가 성공적으로 처리되면 DreamInterviewLoaded 상태로 전환',
      seed: () => DreamInterviewLoaded(interview: tInterview),
      build: () {
        when(mockAddMessage(any)).thenAnswer((_) async => Right(tNewInterview));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const AddMessageEvent(
          interviewId: tInterviewId,
          speakerType: tSpeakerType,
          content: tContent,
        ));
      },
      expect: () => [
        isA<DreamInterviewLoaded>().having(
          (state) => state.interview,
          'interview',
          tNewInterview,
        ),
      ],
      verify: (_) {
        verify(mockAddMessage(const AddMessageParams(
          interviewId: tInterviewId,
          speakerType: tSpeakerType,
          content: tContent,
        ))).called(1);
      },
    );

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '메시지 추가 중 오류 발생 시 DreamInterviewError 상태로 전환',
      seed: () => DreamInterviewLoaded(interview: tInterview),
      build: () {
        when(mockAddMessage(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: '메시지 전송 실패')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const AddMessageEvent(
        interviewId: tInterviewId,
        speakerType: tSpeakerType,
        content: tContent,
      )),
      expect: () => [
        isA<DreamInterviewError>().having(
          (state) => state.message,
          'error message',
          '메시지 전송 실패',
        ),
      ],
      verify: (_) {
        verify(mockAddMessage(any)).called(1);
      },
    );
  });

  group('GetBotResponseEvent', () {
    const tBotResponse = '안녕하세요, 무엇을 도와드릴까요?';
    final tPreviousMessages = [tMessage];

    setUp(() {
      _setupFromStartInterview();
    });

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '봇 응답 요청이 성공적으로 처리되면 DreamInterviewBotResponseLoaded 상태로 전환',
      seed: () => DreamInterviewLoaded(interview: tInterview),
      build: () {
        when(mockGetBotResponse(any))
            .thenAnswer((_) async => const Right(tBotResponse));
        when(mockAddMessage(any)).thenAnswer((_) async => Right(tInterview));
        return bloc;
      },
      act: (bloc) => bloc.add(GetBotResponseEvent(
        interviewId: tInterviewId,
        previousMessages: tPreviousMessages,
      )),
      expect: () => [
        isA<BotResponseLoadingState>().having(
          (state) => state.interview,
          'interview',
          tInterview,
        ),
        isA<DreamInterviewBotResponseLoaded>().having(
          (state) => state.response,
          'response',
          tBotResponse,
        ),
        isA<DreamInterviewLoaded>(),
      ],
      verify: (_) {
        verify(mockGetBotResponse(BotResponseParams(
          interviewId: tInterviewId,
          previousMessages: tPreviousMessages,
        ))).called(1);
        verify(mockAddMessage(const AddMessageParams(
          interviewId: tInterviewId,
          speakerType: SpeakerType.bot,
          content: tBotResponse,
        ))).called(1);
      },
    );

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '봇 응답 요청 중 오류 발생 시 DreamInterviewError 상태로 전환',
      seed: () => DreamInterviewLoaded(interview: tInterview),
      build: () {
        when(mockGetBotResponse(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: '봇 응답 요청 실패')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetBotResponseEvent(
        interviewId: tInterviewId,
        previousMessages: tPreviousMessages,
      )),
      expect: () => [
        isA<BotResponseLoadingState>(),
        isA<DreamInterviewError>().having(
          (state) => state.message,
          'error message',
          '봇 응답 요청 실패',
        ),
      ],
      verify: (_) {
        verify(mockGetBotResponse(any)).called(1);
      },
    );
  });

  group('CompleteInterviewEvent', () {
    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '인터뷰 완료가 성공적으로 처리되면 DreamInterviewCompleted 상태로 전환',
      seed: () => DreamInterviewLoaded(interview: tInterview),
      build: () {
        when(mockCompleteInterview(any))
            .thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const CompleteInterviewEvent(interviewId: tInterviewId)),
      expect: () => [
        isA<InitialLoadingState>(),
        isA<DreamInterviewCompleted>(),
      ],
      verify: (_) {
        verify(mockCompleteInterview(const CompleteInterviewParams(
          interviewId: tInterviewId,
        ))).called(1);
      },
    );

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '인터뷰 완료 중 오류 발생 시 DreamInterviewError 상태로 전환',
      seed: () => DreamInterviewLoaded(interview: tInterview),
      build: () {
        when(mockCompleteInterview(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: '인터뷰 완료 실패')),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const CompleteInterviewEvent(interviewId: tInterviewId)),
      expect: () => [
        isA<InitialLoadingState>(),
        isA<DreamInterviewError>().having(
          (state) => state.message,
          'error message',
          '인터뷰 완료 실패',
        ),
      ],
      verify: (_) {
        verify(mockCompleteInterview(any)).called(1);
      },
    );
  });

  group('ConvertVoiceToTextEvent', () {
    setUp(() {
      _setupFromStartInterview();
    });

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '음성-텍스트 변환이 성공적으로 처리되면 VoiceToTextLoaded 상태로 전환',
      seed: () => DreamInterviewLoaded(interview: tInterview),
      build: () {
        when(mockConvertVoiceToText(any))
            .thenAnswer((_) async => const Right(tVoiceText));
        return bloc;
      },
      act: (bloc) => bloc.add(ConvertVoiceToTextEvent(audioData: tAudioData)),
      expect: () => [
        isA<VoiceToTextLoadingState>(),
        isA<VoiceToTextLoaded>().having(
          (state) => state.text,
          'text',
          tVoiceText,
        ),
      ],
      verify: (_) {
        verify(mockConvertVoiceToText(AudioDataParams(
          audioData: tAudioData,
        ))).called(1);
      },
    );

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '음성-텍스트 변환 중 오류 발생 시 DreamInterviewError 상태로 전환',
      seed: () => DreamInterviewLoaded(interview: tInterview),
      build: () {
        when(mockConvertVoiceToText(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: '음성 인식 실패')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(ConvertVoiceToTextEvent(audioData: tAudioData)),
      expect: () => [
        isA<VoiceToTextLoadingState>(),
        isA<DreamInterviewError>().having(
          (state) => state.message,
          'error message',
          '음성 인식 실패',
        ),
      ],
      verify: (_) {
        verify(mockConvertVoiceToText(any)).called(1);
      },
    );
  });

  group('GetCurrentInterviewEvent', () {
    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '현재 인터뷰 조회가 성공적으로 처리되면 DreamInterviewLoaded 상태로 전환',
      build: () {
        when(mockGetCurrentInterview(any))
            .thenAnswer((_) async => Right(tInterview));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const GetCurrentInterviewEvent(interviewId: tInterviewId)),
      expect: () => [
        isA<InitialLoadingState>(),
        isA<DreamInterviewLoaded>().having(
          (state) => state.interview,
          'interview',
          tInterview,
        ),
      ],
      verify: (_) {
        verify(mockGetCurrentInterview(const InterviewIdParams(
          interviewId: tInterviewId,
        ))).called(1);
      },
    );

    blocTest<DreamInterviewBloc, DreamInterviewState>(
      '현재 인터뷰 조회 중 오류 발생 시 DreamInterviewError 상태로 전환',
      build: () {
        when(mockGetCurrentInterview(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: '인터뷰 조회 실패')),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const GetCurrentInterviewEvent(interviewId: tInterviewId)),
      expect: () => [
        isA<InitialLoadingState>(),
        isA<DreamInterviewError>().having(
          (state) => state.message,
          'error message',
          '인터뷰 조회 실패',
        ),
      ],
      verify: (_) {
        verify(mockGetCurrentInterview(any)).called(1);
      },
    );
  });
}
