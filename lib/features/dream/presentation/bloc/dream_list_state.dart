part of 'dream_list_bloc.dart';

sealed class DreamListState extends Equatable {
  const DreamListState();

  @override
  List<Object?> get props => [];
}

class DreamListInitial extends DreamListState {
  const DreamListInitial();
}

class DreamListLoading extends DreamListState {
  const DreamListLoading();
}

class DreamListLoaded extends DreamListState {
  final DreamList dreamList;
  final FilterType filterType;
  final String? searchQuery;
  final String? mood;
  final DateTime? startDate;
  final DateTime? endDate;

  const DreamListLoaded({
    required this.dreamList,
    this.filterType = FilterType.all,
    this.searchQuery,
    this.mood,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props =>
      [dreamList, filterType, searchQuery, mood, startDate, endDate];

  DreamListLoaded copyWith({
    DreamList? dreamList,
    FilterType? filterType,
    String? searchQuery,
    String? mood,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return DreamListLoaded(
      dreamList: dreamList ?? this.dreamList,
      filterType: filterType ?? this.filterType,
      searchQuery: searchQuery ?? this.searchQuery,
      mood: mood ?? this.mood,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class DreamListError extends DreamListState {
  final String message;

  const DreamListError({required this.message});

  @override
  List<Object?> get props => [message];
}
