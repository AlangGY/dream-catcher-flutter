import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/core/use-cases/use_case.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/dream_interview_repository.dart';

class CompleteInterview extends UseCase<Unit, CompleteInterviewParams> {
  final DreamInterviewRepository repository;

  CompleteInterview(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CompleteInterviewParams params) {
    return repository.completeInterview(params.interviewId);
  }
}

class CompleteInterviewParams extends Equatable {
  final String interviewId;

  const CompleteInterviewParams({
    required this.interviewId,
  });

  @override
  List<Object?> get props => [interviewId];
}
