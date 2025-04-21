import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/core/use-cases/use_case.dart';

import '../../entities/dream_interview.dart';
import '../../repositories/dream_interview_repository.dart';

class StartInterview extends UseCaseNoParams<DreamInterview> {
  final DreamInterviewRepository repository;

  StartInterview(this.repository);

  @override
  Future<Either<Failure, DreamInterview>> call() {
    return repository.startInterview();
  }
}
