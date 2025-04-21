part of 'dream_detail_bloc.dart';

sealed class DreamDetailState extends Equatable {
  const DreamDetailState();

  @override
  List<Object> get props => [];
}

final class DreamDetailInitial extends DreamDetailState {}

final class DreamDetailLoading extends DreamDetailState {}

final class DreamDetailLoaded extends DreamDetailState {
  final DreamDetail dream;

  const DreamDetailLoaded({required this.dream});

  @override
  List<Object> get props => [dream];
}

final class DreamDetailError extends DreamDetailState {
  final String message;

  const DreamDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
