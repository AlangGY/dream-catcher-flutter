import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_interview_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/start_interview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamInterviewRepository>()])
import 'start_interview_test.mocks.dart';

void main() {
  late StartInterview usecase;
  late MockDreamInterviewRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamInterviewRepository();
    usecase = StartInterview(mockRepository);
  });

  final tDreamInterview = DreamInterview(
    id: 'interview123',
    messages: [],
    date: DateTime(2024, 3, 15),
    isCompleted: false,
  );

  test(
    '새로운 인터뷰를 시작한다',
    () async {
      // arrange
      when(mockRepository.startInterview())
          .thenAnswer((_) async => Right(tDreamInterview));

      // act
      final result = await usecase();

      // assert
      expect(result, Right(tDreamInterview));
      verify(mockRepository.startInterview());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
