import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use-cases/use_case.dart';
import '../entities/dream_detail.dart';
import '../repositories/dream_repository.dart';

class GetDreamParams extends Equatable {
  final String dreamId;

  const GetDreamParams({required this.dreamId});

  @override
  List<Object?> get props => [dreamId];
}

class GetDream implements UseCase<DreamDetail, GetDreamParams> {
  final DreamRepository repository;

  GetDream(this.repository);

  @override
  Future<Either<Failure, DreamDetail>> call(GetDreamParams params) async {
    return repository.getDream(params.dreamId);
  }
}
