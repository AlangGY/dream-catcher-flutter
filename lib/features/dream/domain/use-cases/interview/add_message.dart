import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/core/use-cases/use_case.dart';
import 'package:equatable/equatable.dart';

import '../../entities/dream_interview.dart';
import '../../repositories/dream_interview_repository.dart';

class AddMessage extends UseCase<DreamInterview, AddMessageParams> {
  final DreamInterviewRepository repository;

  AddMessage(this.repository);

  @override
  Future<Either<Failure, DreamInterview>> call(AddMessageParams params) {
    return repository.addMessage(
      params.interviewId,
      params.speakerType,
      params.content,
    );
  }
}

class AddMessageParams extends Equatable {
  final String interviewId;
  final SpeakerType speakerType;
  final String content;

  const AddMessageParams({
    required this.interviewId,
    required this.speakerType,
    required this.content,
  });

  @override
  List<Object?> get props => [interviewId, speakerType, content];
}
