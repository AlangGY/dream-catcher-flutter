import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dreams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamRepository>()])
import 'get_dreams_test.mocks.dart';

void main() {
  late GetDreams usecase;
  late MockDreamRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamRepository();
    usecase = GetDreams(mockRepository);
  });

  final tDreamList = DreamList(
    dreams: [
      DreamListItem(
        title: '바다에서 수영하는 꿈',
        date: DateTime(2024, 3, 15),
        mood: '평화로움',
        color: const Color(0xff6fafcc),
        content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
      ),
    ],
  );

  test(
    '저장소에서 꿈 목록을 가져온다',
    () async {
      // arrange
      when(mockRepository.getDreams())
          .thenAnswer((_) async => Right(tDreamList));

      // act
      final result = await usecase();

      // assert
      expect(result, Right(tDreamList));
      verify(mockRepository.getDreams());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
