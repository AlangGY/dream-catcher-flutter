part of 'dream_detail_bloc.dart';

sealed class DreamDetailEvent extends Equatable {
  const DreamDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadDreamEvent extends DreamDetailEvent {
  final String dreamId;

  const LoadDreamEvent({required this.dreamId});

  @override
  List<Object> get props => [dreamId];
}
