import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/delete_dream.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamRepository>()])
import 'delete_dream_test.mocks.dart';

void main() {
  late DeleteDream usecase;
  late MockDreamRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamRepository();
    usecase = DeleteDream(mockRepository);
  });

  const tDreamId = '바다에서 수영하는 꿈';

  test(
    '저장소에서 꿈을 삭제한다',
    () async {
      // arrange
      when(mockRepository.deleteDream(tDreamId))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await usecase(DeleteDreamParams(dreamId: tDreamId));

      // assert
      expect(result, const Right(unit));
      verify(mockRepository.deleteDream(tDreamId));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
