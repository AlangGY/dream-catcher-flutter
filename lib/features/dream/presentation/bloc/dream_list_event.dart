part of 'dream_list_bloc.dart';

enum FilterType { all, recent, mood, tag, search, date }

sealed class DreamListEvent extends Equatable {
  const DreamListEvent();

  @override
  List<Object?> get props => [];
}

class GetDreamsEvent extends DreamListEvent {
  const GetDreamsEvent();
}

class DeleteDreamEvent extends DreamListEvent {
  final String dreamId;

  const DeleteDreamEvent({required this.dreamId});

  @override
  List<Object?> get props => [dreamId];
}

class SearchDreamsEvent extends DreamListEvent {
  final String query;

  const SearchDreamsEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class FilterDreamsByMoodEvent extends DreamListEvent {
  final String mood;

  const FilterDreamsByMoodEvent({required this.mood});

  @override
  List<Object?> get props => [mood];
}

class FilterDreamsByDateEvent extends DreamListEvent {
  final DateTime startDate;
  final DateTime endDate;

  const FilterDreamsByDateEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

class ChangeFilterTypeEvent extends DreamListEvent {
  final FilterType filterType;

  const ChangeFilterTypeEvent({required this.filterType});

  @override
  List<Object?> get props => [filterType];
}

class ClearFiltersEvent extends DreamListEvent {
  const ClearFiltersEvent();
}
