import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/delete_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_date.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_mood.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/save_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/search_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/update_dream.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<GetDreams>(),
  MockSpec<SaveDream>(),
  MockSpec<UpdateDream>(),
  MockSpec<DeleteDream>(),
  MockSpec<SearchDreams>(),
  MockSpec<FilterDreamsByMood>(),
  MockSpec<FilterDreamsByDate>(),
])
import 'dream_list_bloc_test.mocks.dart';

void main() {
  late MockGetDreams mockGetDreams;
  late MockSaveDream mockSaveDream;
  late MockUpdateDream mockUpdateDream;
  late MockDeleteDream mockDeleteDream;
  late MockSearchDreams mockSearchDreams;
  late MockFilterDreamsByMood mockFilterDreamsByMood;
  late MockFilterDreamsByDate mockFilterDreamsByDate;

  setUp(() {
    mockGetDreams = MockGetDreams();
    mockSaveDream = MockSaveDream();
    mockUpdateDream = MockUpdateDream();
    mockDeleteDream = MockDeleteDream();
    mockSearchDreams = MockSearchDreams();
    mockFilterDreamsByMood = MockFilterDreamsByMood();
    mockFilterDreamsByDate = MockFilterDreamsByDate();
  });

  final tDream = DreamListItem(
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xff6fafcc),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
  );

  final tDreamDetail = DreamDetail(
    id: '1',
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xff6fafcc),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
    tags: ['바다', '수영'],
    people: ['없음'],
    clearness: 4,
    lucidity: 2,
    symbolism: '자유, 평화',
    interpretation: '내면의 평화와 자유를 향한 욕구를 상징합니다.',
  );

  final tDreamList = DreamList(dreams: [tDream]);

  DreamListBloc buildBloc() {
    return DreamListBloc(
      getDreams: mockGetDreams,
      saveDream: mockSaveDream,
      updateDream: mockUpdateDream,
      deleteDream: mockDeleteDream,
      searchDreams: mockSearchDreams,
      filterDreamsByMood: mockFilterDreamsByMood,
      filterDreamsByDate: mockFilterDreamsByDate,
    );
  }

  group('GetDreamsEvent', () {
    test('초기 상태는 DreamListInitial 이어야 함', () {
      expect(buildBloc().state, const DreamListInitial());
    });

    blocTest<DreamListBloc, DreamListState>(
      'GetDreamsEvent가 성공적으로 처리되면 DreamListLoaded 상태로 전환',
      build: () {
        when(mockGetDreams()).thenAnswer((_) async => Right(tDreamList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const GetDreamsEvent()),
      expect: () => [
        const DreamListLoading(),
        isA<DreamListLoaded>(),
      ],
      verify: (_) {
        verify(mockGetDreams()).called(1);
      },
    );

    blocTest<DreamListBloc, DreamListState>(
      'GetDreamsEvent가 실패하면 DreamListError 상태로 전환',
      build: () {
        when(mockGetDreams()).thenAnswer((_) async => Left(ServerFailure()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const GetDreamsEvent()),
      expect: () => [
        const DreamListLoading(),
        isA<DreamListError>(),
      ],
      verify: (_) {
        verify(mockGetDreams()).called(1);
      },
    );
  });

  group('SearchDreamsEvent', () {
    const tQuery = '바다';

    blocTest<DreamListBloc, DreamListState>(
      'SearchDreamsEvent가 성공적으로 처리되면 필터 타입이 search인 DreamListLoaded 상태로 전환',
      build: () {
        when(mockSearchDreams(any)).thenAnswer((_) async => Right(tDreamList));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SearchDreamsEvent(query: tQuery)),
      expect: () => [
        const DreamListLoading(),
        predicate<DreamListLoaded>((state) =>
            state.filterType == FilterType.search &&
            state.searchQuery == tQuery),
      ],
      verify: (_) {
        verify(mockSearchDreams(SearchDreamsParams(query: tQuery))).called(1);
      },
    );
  });

  group('ChangeFilterTypeEvent', () {
    blocTest<DreamListBloc, DreamListState>(
      '이미 로드된 상태에서 필터 타입 변경 시 필터 타입만 변경되어야 함',
      seed: () => DreamListLoaded(
        dreamList: tDreamList,
        filterType: FilterType.all,
      ),
      build: () => buildBloc(),
      act: (bloc) =>
          bloc.add(const ChangeFilterTypeEvent(filterType: FilterType.mood)),
      expect: () => [
        predicate<DreamListLoaded>((state) =>
            state.filterType == FilterType.mood &&
            state.dreamList == tDreamList),
      ],
    );
  });
}
