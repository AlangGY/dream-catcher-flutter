import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_interview_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/get_bot_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamInterviewRepository>()])
import 'get_bot_response_test.mocks.dart';

void main() {
  late GetBotResponse usecase;
  late MockDreamInterviewRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamInterviewRepository();
    usecase = GetBotResponse(mockRepository);
  });

  final tInterviewId = 'interview123';
  final tPreviousMessages = [
    DreamInterviewMessage(
      id: 'bot1',
      speakerType: SpeakerType.bot,
      content: '안녕하세요. 꿈 인터뷰를 시작합니다. 어떤 꿈을 꾸셨나요?',
      timestamp: DateTime(2024, 3, 15, 10, 25),
    ),
    DreamInterviewMessage(
      id: 'me1',
      speakerType: SpeakerType.me,
      content: '저는 바다에서 수영하는 꿈을 꾸었어요',
      timestamp: DateTime(2024, 3, 15, 10, 30),
    ),
  ];

  final tResponseContent = '그 꿈에서 어떤 감정을 느끼셨나요?';

  test(
    'API를 통해 봇의 응답을 가져온다',
    () async {
      // arrange
      when(mockRepository.getBotResponse(tInterviewId, tPreviousMessages))
          .thenAnswer((_) async => Right(tResponseContent));

      // act
      final result = await usecase(
        BotResponseParams(
          interviewId: tInterviewId,
          previousMessages: tPreviousMessages,
        ),
      );

      // assert
      expect(result, Right(tResponseContent));
      verify(mockRepository.getBotResponse(tInterviewId, tPreviousMessages));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
