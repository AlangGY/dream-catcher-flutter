import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_interview_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/add_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamInterviewRepository>()])
import 'add_message_test.mocks.dart';

void main() {
  late AddMessage usecase;
  late MockDreamInterviewRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamInterviewRepository();
    usecase = AddMessage(mockRepository);
  });

  const tInterviewId = 'interview123';
  const tSpeakerType = SpeakerType.me;
  const tContent = '저는 바다에서 수영하는 꿈을 꾸었어요';

  final tMessage = DreamInterviewMessage(
    id: 'msg123',
    speakerType: tSpeakerType,
    content: tContent,
    timestamp: DateTime(2024, 3, 15, 10, 30),
  );

  final tDreamInterview = DreamInterview(
    id: tInterviewId,
    messages: [tMessage],
    date: DateTime(2024, 3, 15),
    isCompleted: false,
  );

  test(
    '인터뷰에 새 메시지를 추가한다',
    () async {
      // arrange
      when(mockRepository.addMessage(tInterviewId, tSpeakerType, tContent))
          .thenAnswer((_) async => Right(tDreamInterview));

      // act
      final result = await usecase(
        const AddMessageParams(
          interviewId: tInterviewId,
          speakerType: tSpeakerType,
          content: tContent,
        ),
      );

      // assert
      expect(result, Right(tDreamInterview));
      verify(mockRepository.addMessage(tInterviewId, tSpeakerType, tContent));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
