import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/save_dream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamRepository>()])
import 'save_dream_test.mocks.dart';

void main() {
  late SaveDream usecase;
  late MockDreamRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamRepository();
    usecase = SaveDream(mockRepository);
  });

  final tDream = DreamDetail(
    id: '1',
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xff6fafcc),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
    tags: ['바다', '수영', '물고기'],
    people: ['없음'],
    clearness: 4,
    lucidity: 2,
    symbolism: '자유, 평화',
    interpretation: '바다는 내면의 감정과 무의식을 상징하는 것 같다.',
  );

  test(
    '저장소에 새로운 꿈을 저장한다',
    () async {
      // arrange
      when(mockRepository.saveDream(tDream))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await usecase(SaveDreamParams(dream: tDream));

      // assert
      expect(result, const Right(unit));
      verify(mockRepository.saveDream(tDream));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
