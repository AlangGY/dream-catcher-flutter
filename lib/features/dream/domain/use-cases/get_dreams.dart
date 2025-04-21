import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use-cases/use_case.dart';
import '../entities/dream_list.dart';
import '../repositories/dream_repository.dart';

class GetDreams implements UseCaseNoParams<DreamList> {
  final DreamRepository repository;

  GetDreams(this.repository);

  @override
  Future<Either<Failure, DreamList>> call() async {
    return repository.getDreams();
  }
}
