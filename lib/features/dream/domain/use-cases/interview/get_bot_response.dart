import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/core/use-cases/use_case.dart';
import 'package:equatable/equatable.dart';

import '../../entities/dream_interview.dart';
import '../../repositories/dream_interview_repository.dart';

class GetBotResponse extends UseCase<String, BotResponseParams> {
  final DreamInterviewRepository repository;

  GetBotResponse(this.repository);

  @override
  Future<Either<Failure, String>> call(BotResponseParams params) {
    return repository.getBotResponse(
      params.interviewId,
      params.previousMessages,
    );
  }
}

class BotResponseParams extends Equatable {
  final String interviewId;
  final List<DreamInterviewMessage> previousMessages;

  const BotResponseParams({
    required this.interviewId,
    required this.previousMessages,
  });

  @override
  List<Object?> get props => [interviewId, previousMessages];
}
