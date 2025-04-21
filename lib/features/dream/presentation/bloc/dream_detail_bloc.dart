import 'package:bloc/bloc.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dream.dart';
import 'package:equatable/equatable.dart';

part 'dream_detail_event.dart';
part 'dream_detail_state.dart';

class DreamDetailBloc extends Bloc<DreamDetailEvent, DreamDetailState> {
  final GetDream getDream;

  DreamDetailBloc({required this.getDream}) : super(DreamDetailInitial()) {
    on<LoadDreamEvent>(_onLoadDream);
  }

  Future<void> _onLoadDream(
      LoadDreamEvent event, Emitter<DreamDetailState> emit) async {
    emit(DreamDetailLoading());

    final result = await getDream(GetDreamParams(dreamId: event.dreamId));

    result.fold(
      (failure) => emit(DreamDetailError(
          message: const bool.fromEnvironment('dart.vm.product')
              ? '꿈을 불러오는데 실패했습니다.'
              : failure.toString())),
      (dream) => emit(DreamDetailLoaded(dream: dream)),
    );
  }
}
