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
      '데이터 소스에서 예외가 발생하면 ServerFailure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.getDreams()).thenThrow(Exception());

        // act
        final result = await repository.getDreams();

        // assert
        expect(result, Left(ServerFailure()));
        verify(mockDataSource.getDreams());
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
      '꿈 저장 중 예외가 발생하면 ServerFailure를 반환해야 한다',
      () async {
        // arrange
        when(mockDetailFactory.fromEntity(tDreamDetail))
            .thenReturn(tDreamDetailModel);
        when(mockDataSource.saveDream(tDreamDetailModel))
            .thenThrow(Exception());

        // act
        final result = await repository.saveDream(tDreamDetail);

        // assert
        expect(result, Left(ServerFailure()));
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
      '검색 중 예외가 발생하면 ServerFailure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.searchDreams(tQuery)).thenThrow(Exception());

        // act
        final result = await repository.searchDreams(tQuery);

        // assert
        expect(result, Left(ServerFailure()));
        verify(mockDataSource.searchDreams(tQuery));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}
