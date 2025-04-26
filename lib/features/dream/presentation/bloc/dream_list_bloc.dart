import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/delete_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_date.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_mood.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/search_dreams.dart';
import 'package:equatable/equatable.dart';

part 'dream_list_event.dart';
part 'dream_list_state.dart';

class DreamListBloc extends Bloc<DreamListEvent, DreamListState> {
  final GetDreams getDreams;
  final DeleteDream deleteDream;
  final SearchDreams searchDreams;
  final FilterDreamsByMood filterDreamsByMood;
  final FilterDreamsByDate filterDreamsByDate;

  DreamListBloc({
    required this.getDreams,
    required this.deleteDream,
    required this.searchDreams,
    required this.filterDreamsByMood,
    required this.filterDreamsByDate,
  }) : super(const DreamListInitial()) {
    on<GetDreamsEvent>(_onGetDreams);
    on<DeleteDreamEvent>(_onDeleteDream);
    on<SearchDreamsEvent>(_onSearchDreams);
    on<FilterDreamsByMoodEvent>(_onFilterDreamsByMood);
    on<FilterDreamsByDateEvent>(_onFilterDreamsByDate);
    on<ChangeFilterTypeEvent>(_onChangeFilterType);
    on<ClearFiltersEvent>(_onClearFilters);
  }

  Future<void> _onGetDreams(
      GetDreamsEvent event, Emitter<DreamListState> emit) async {
    emit(const DreamListLoading());
    final result = await getDreams();
    emit(_eitherLoadedOrErrorState(result));
  }

  Future<void> _onDeleteDream(
      DeleteDreamEvent event, Emitter<DreamListState> emit) async {
    emit(const DreamListLoading());
    final result = await deleteDream(DeleteDreamParams(dreamId: event.dreamId));

    result.fold(
      (failure) => emit(DreamListError(message: _mapFailureToMessage(failure))),
      (_) => add(const GetDreamsEvent()), // 삭제 성공 후 목록 새로고침
    );
  }

  Future<void> _onSearchDreams(
      SearchDreamsEvent event, Emitter<DreamListState> emit) async {
    emit(const DreamListLoading());
    final result = await searchDreams(SearchDreamsParams(query: event.query));
    emit(_eitherLoadedOrErrorState(result,
        filterType: FilterType.search, searchQuery: event.query));
  }

  Future<void> _onFilterDreamsByMood(
      FilterDreamsByMoodEvent event, Emitter<DreamListState> emit) async {
    emit(const DreamListLoading());
    final result =
        await filterDreamsByMood(FilterDreamsByMoodParams(mood: event.mood));
    emit(_eitherLoadedOrErrorState(result,
        filterType: FilterType.mood, mood: event.mood));
  }

  Future<void> _onFilterDreamsByDate(
      FilterDreamsByDateEvent event, Emitter<DreamListState> emit) async {
    emit(const DreamListLoading());
    final result = await filterDreamsByDate(
      FilterDreamsByDateParams(
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );
    emit(_eitherLoadedOrErrorState(result,
        filterType: FilterType.date,
        startDate: event.startDate,
        endDate: event.endDate));
  }

  void _onChangeFilterType(
      ChangeFilterTypeEvent event, Emitter<DreamListState> emit) {
    // 현재 상태가 데이터를 이미 가지고 있는 경우에만 필터 타입 변경
    if (state is DreamListLoaded) {
      final currentState = state as DreamListLoaded;
      emit(currentState.copyWith(filterType: event.filterType));
    }
  }

  void _onClearFilters(ClearFiltersEvent event, Emitter<DreamListState> emit) {
    add(const GetDreamsEvent());
  }

  DreamListState _eitherLoadedOrErrorState(
    Either<Failure, DreamList> result, {
    FilterType filterType = FilterType.all,
    String? searchQuery,
    String? mood,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return result.fold(
      (failure) => DreamListError(message: _mapFailureToMessage(failure)),
      (dreamList) => DreamListLoaded(
        dreamList: dreamList,
        filterType: filterType,
        searchQuery: searchQuery,
        mood: mood,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return '서버 오류가 발생했습니다.';
      default:
        return '예상치 못한 오류가 발생했습니다.';
    }
  }
}
