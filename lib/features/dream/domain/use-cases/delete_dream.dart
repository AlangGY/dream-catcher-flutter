import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use-cases/use_case.dart';
import '../repositories/dream_repository.dart';

class DeleteDream implements UseCase<Unit, DeleteDreamParams> {
  final DreamRepository repository;

  DeleteDream(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteDreamParams params) async {
    return repository.deleteDream(params.dreamId);
  }
}

class DeleteDreamParams extends Equatable {
  final String dreamId;

  const DeleteDreamParams({required this.dreamId});

  @override
  List<Object?> get props => [dreamId];
}
