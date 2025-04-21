import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_repository.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/search_dreams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DreamRepository>()])
import 'search_dreams_test.mocks.dart';

void main() {
  late SearchDreams usecase;
  late MockDreamRepository mockRepository;

  setUp(() {
    mockRepository = MockDreamRepository();
    usecase = SearchDreams(mockRepository);
  });

  final tQuery = '바다';

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
    '검색어로 저장소에서 꿈을 검색한다',
    () async {
      // arrange
      when(mockRepository.searchDreams(tQuery))
          .thenAnswer((_) async => Right(tDreamList));

      // act
      final result = await usecase(SearchDreamsParams(query: tQuery));

      // assert
      expect(result, Right(tDreamList));
      verify(mockRepository.searchDreams(tQuery));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
