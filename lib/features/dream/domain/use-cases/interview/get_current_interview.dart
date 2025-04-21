import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/core/use-cases/use_case.dart';
import 'package:equatable/equatable.dart';

import '../../entities/dream_interview.dart';
import '../../repositories/dream_interview_repository.dart';

class GetCurrentInterview extends UseCase<DreamInterview, InterviewIdParams> {
  final DreamInterviewRepository repository;

  GetCurrentInterview(this.repository);

  @override
  Future<Either<Failure, DreamInterview>> call(InterviewIdParams params) {
    return repository.getCurrentInterview(params.interviewId);
  }
}

class InterviewIdParams extends Equatable {
  final String interviewId;

  const InterviewIdParams({
    required this.interviewId,
  });

  @override
  List<Object?> get props => [interviewId];
}
