import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_interview_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/complete_interview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamInterviewRepository>()])
import 'complete_interview_test.mocks.dart';

void main() {
  late CompleteInterview usecase;
  late MockDreamInterviewRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamInterviewRepository();
    usecase = CompleteInterview(mockRepository);
  });

  const tInterviewId = 'interview123';

  test(
    '인터뷰를 완료하고 꿈 기록으로 저장한다',
    () async {
      // arrange
      when(mockRepository.completeInterview(tInterviewId))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await usecase(
        const CompleteInterviewParams(
          interviewId: tInterviewId,
        ),
      );

      // assert
      expect(result, const Right(unit));
      verify(mockRepository.completeInterview(tInterviewId));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
