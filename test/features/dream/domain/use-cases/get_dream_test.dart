import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamRepository>()])
import 'get_dream_test.mocks.dart';

void main() {
  late GetDream usecase;
  late MockDreamRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamRepository();
    usecase = GetDream(mockRepository);
  });

  final tDreamId = 'dream001';
  final tDreamDetail = DreamDetail(
    id: tDreamId,
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xFF6699CC),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다.',
    tags: ['바다', '수영', '물고기', '평화'],
    people: ['없음'],
    clearness: 4,
    lucidity: 2,
    symbolism: '자유, 평화, 새로운 시작',
    interpretation:
        '바다는 내면의 감정과 무의식을 상징한다고 하는데, 푸른 바다에서 자유롭게 수영하는 꿈은 현재 내 마음이 평화롭고 안정되어 있음을 의미하는 것 같다.',
  );

  test(
    '저장소에서 특정 꿈의 상세 정보를 가져온다',
    () async {
      // arrange
      when(mockRepository.getDream(tDreamId))
          .thenAnswer((_) async => Right(tDreamDetail));

      // act
      final result = await usecase(GetDreamParams(dreamId: tDreamId));

      // assert
      expect(result, Right(tDreamDetail));
      verify(mockRepository.getDream(tDreamId));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
