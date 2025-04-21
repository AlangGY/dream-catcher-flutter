import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use-cases/use_case.dart';
import '../entities/dream_detail.dart';
import '../repositories/dream_repository.dart';

class SaveDream implements UseCase<Unit, SaveDreamParams> {
  final DreamRepository repository;

  SaveDream(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SaveDreamParams params) async {
    return repository.saveDream(params.dream);
  }
}

class SaveDreamParams extends Equatable {
  final DreamDetail dream;

  const SaveDreamParams({required this.dream});

  @override
  List<Object?> get props => [dream];
}
