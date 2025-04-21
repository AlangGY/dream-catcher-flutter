import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use-cases/use_case.dart';
import '../entities/dream_detail.dart';
import '../repositories/dream_repository.dart';

class UpdateDream implements UseCase<Unit, UpdateDreamParams> {
  final DreamRepository repository;

  UpdateDream(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateDreamParams params) async {
    return repository.updateDream(params.dream);
  }
}

class UpdateDreamParams extends Equatable {
  final DreamDetail dream;

  const UpdateDreamParams({required this.dream});

  @override
  List<Object?> get props => [dream];
}
