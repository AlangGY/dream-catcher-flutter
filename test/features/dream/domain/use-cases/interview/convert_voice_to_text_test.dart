import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_interview_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/convert_voice_to_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamInterviewRepository>()])
import 'convert_voice_to_text_test.mocks.dart';

void main() {
  late ConvertVoiceToText usecase;
  late MockDreamInterviewRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamInterviewRepository();
    usecase = ConvertVoiceToText(mockRepository);
  });

  final tAudioData = List<int>.generate(1000, (i) => i % 256); // 샘플 오디오 데이터
  final tTextResult = '저는 바다에서 수영하는 꿈을 꾸었어요';

  test(
    '음성 데이터를 텍스트로 변환한다',
    () async {
      // arrange
      when(mockRepository.convertVoiceToText(tAudioData))
          .thenAnswer((_) async => Right(tTextResult));

      // act
      final result = await usecase(
        AudioDataParams(
          audioData: tAudioData,
        ),
      );

      // assert
      expect(result, Right(tTextResult));
      verify(mockRepository.convertVoiceToText(tAudioData));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
