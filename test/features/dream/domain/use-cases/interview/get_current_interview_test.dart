import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_interview_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/get_current_interview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamInterviewRepository>()])
import 'get_current_interview_test.mocks.dart';

void main() {
  late GetCurrentInterview usecase;
  late MockDreamInterviewRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamInterviewRepository();
    usecase = GetCurrentInterview(mockRepository);
  });

  const tInterviewId = 'interview123';
  final tMessages = [
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

  final tDreamInterview = DreamInterview(
    id: tInterviewId,
    messages: tMessages,
    date: DateTime(2024, 3, 15),
    isCompleted: false,
  );

  test(
    '진행 중인 인터뷰를 가져온다',
    () async {
      // arrange
      when(mockRepository.getCurrentInterview(tInterviewId))
          .thenAnswer((_) async => Right(tDreamInterview));

      // act
      final result = await usecase(
        const InterviewIdParams(
          interviewId: tInterviewId,
        ),
      );

      // assert
      expect(result, Right(tDreamInterview));
      verify(mockRepository.getCurrentInterview(tInterviewId));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
