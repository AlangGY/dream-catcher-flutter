import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_detail_model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_item_model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_model.dart';
import 'package:dream_catcher/features/dream/data/repositories/dream_repository_impl.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// MockDreamDataSource는 수동으로 테스트용으로 정의

@GenerateNiceMocks(
  [
    MockSpec<DreamDataSource>(),
    MockSpec<DreamListModelFactory>(),
    MockSpec<DreamListItemModelFactory>(),
    MockSpec<DreamDetailModelFactory>(),
  ],
)
import 'dream_repository_impl_test.mocks.dart';

void main() {
  late DreamRepositoryImpl repository;
  late MockDreamDataSource mockDataSource;
  late MockDreamListModelFactory mockListFactory;
  late MockDreamListItemModelFactory mockItemFactory;
  late MockDreamDetailModelFactory mockDetailFactory;
  setUp(() {
    mockDataSource = MockDreamDataSource();
    mockListFactory = MockDreamListModelFactory();
    mockItemFactory = MockDreamListItemModelFactory();
    mockDetailFactory = MockDreamDetailModelFactory();

    repository = DreamRepositoryImpl(
      dataSource: mockDataSource,
      listFactory: mockListFactory,
      itemFactory: mockItemFactory,
      detailFactory: mockDetailFactory,
    );
  });

  group('getDreams', () {
    final tDreamListItem = DreamListItem(
      id: 'dream001',
      title: '테스트 꿈',
      date: DateTime(2024, 3, 15),
      mood: '평화로움',
      color: const Color(0xFF6699CC),
      content: '테스트 내용',
    );

    final tDreamList = DreamList(dreams: [tDreamListItem]);

    final tDreamListItemModel = DreamListItemModel(
      id: 'dream001',
      title: '테스트 꿈',
      date: DateTime(2024, 3, 15),
      mood: '평화로움',
      color: const Color(0xFF6699CC),
      content: '테스트 내용',
    );

    final tDreamListModel = DreamListModel(dreams: [tDreamListItemModel]);

    test(
      '데이터 소스로부터 꿈 목록을 성공적으로 가져오면 DreamList를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.getDreams())
            .thenAnswer((_) async => tDreamListModel);

        // act
        final result = await repository.getDreams();

        // assert
        expect(result, Right(tDreamList));
        verify(mockDataSource.getDreams());
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '데이터 소스에서 예외가 발생하면 Failure 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.getDreams()).thenThrow(Exception());

        // act
        final result = await repository.getDreams();

        // assert
        expect(result, isA<Left<Failure, DreamList>>());
        verify(mockDataSource.getDreams());
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('getDream', () {
    const tDreamId = 'dream001';

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

    final tDreamDetailModel = DreamDetailModel(
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
      '데이터 소스로부터 특정 꿈 정보를 성공적으로 가져오면 DreamDetail을 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.getDream(tDreamId))
            .thenAnswer((_) async => tDreamDetailModel);

        // act
        final result = await repository.getDream(tDreamId);

        // assert
        expect(result, Right(tDreamDetail));
        verify(mockDataSource.getDream(tDreamId));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '데이터 소스에서 예외가 발생하면 Failure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.getDream(tDreamId)).thenThrow(Exception());

        // act
        final result = await repository.getDream(tDreamId);

        // assert
        expect(result, isA<Left<Failure, DreamDetail>>());
        verify(mockDataSource.getDream(tDreamId));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('saveDream', () {
    final tDreamDetail = DreamDetail(
      id: '1',
      title: '새로운 꿈',
      date: DateTime(2024, 3, 20),
      mood: '설렘',
      color: const Color(0xFF66CC99),
      content: '새로운 꿈 내용',
      tags: ['태그1', '태그2'],
      people: ['사람1', '사람2'],
      clearness: 5,
      lucidity: 3,
      symbolism: '기회',
      interpretation: '새로운 꿈은 새로운 기회를 의미합니다.',
    );

    final tDreamDetailModel = DreamDetailModel(
      id: '1',
      title: '새로운 꿈',
      date: DateTime(2024, 3, 20),
      mood: '설렘',
      color: const Color(0xFF66CC99),
      content: '새로운 꿈 내용',
      tags: ['태그1', '태그2'],
      people: ['사람1', '사람2'],
      clearness: 5,
      lucidity: 3,
      symbolism: '기회',
      interpretation: '새로운 꿈은 새로운 기회를 의미합니다.',
    );

    test(
      '꿈을 성공적으로 저장하면 Right(unit)을 반환해야 한다',
      () async {
        // arrange
        when(mockDetailFactory.fromEntity(tDreamDetail))
            .thenReturn(tDreamDetailModel);
        when(mockDataSource.saveDream(tDreamDetailModel))
            .thenAnswer((_) async => {});

        // act
        final result = await repository.saveDream(tDreamDetail);

        // assert
        expect(result, const Right(unit));
        verify(mockDetailFactory.fromEntity(tDreamDetail));
        verify(mockDataSource.saveDream(tDreamDetailModel));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '꿈 저장 중 예외가 발생하면 Failure를 반환해야 한다',
      () async {
        // arrange
        when(mockDetailFactory.fromEntity(tDreamDetail))
            .thenReturn(tDreamDetailModel);
        when(mockDataSource.saveDream(tDreamDetailModel))
            .thenThrow(Exception());

        // act
        final result = await repository.saveDream(tDreamDetail);

        // assert
        expect(result, isA<Left<Failure, Unit>>());
        verify(mockDetailFactory.fromEntity(tDreamDetail));
        verify(mockDataSource.saveDream(tDreamDetailModel));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('searchDreams', () {
    final tQuery = '테스트';

    final tDreamListItem = DreamListItem(
      id: 'dream001',
      title: '테스트 꿈',
      date: DateTime(2024, 3, 15),
      mood: '평화로움',
      color: const Color(0xFF6699CC),
      content: '테스트 내용',
    );

    final tDreamList = DreamList(dreams: [tDreamListItem]);

    final tDreamListItemModel = DreamListItemModel(
      id: 'dream001',
      title: '테스트 꿈',
      date: DateTime(2024, 3, 15),
      mood: '평화로움',
      color: const Color(0xFF6699CC),
      content: '테스트 내용',
    );

    final tDreamListModel = DreamListModel(dreams: [tDreamListItemModel]);

    test(
      '검색어로 꿈을 성공적으로 검색하면 DreamList를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.searchDreams(tQuery))
            .thenAnswer((_) async => tDreamListModel);

        // act
        final result = await repository.searchDreams(tQuery);

        // assert
        expect(result, Right(tDreamList));
        verify(mockDataSource.searchDreams(tQuery));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '검색 중 예외가 발생하면 Failure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.searchDreams(tQuery)).thenThrow(Exception());

        // act
        final result = await repository.searchDreams(tQuery);

        // assert
        expect(result, isA<Left<Failure, DreamList>>());
        verify(mockDataSource.searchDreams(tQuery));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}
