import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/core/use-cases/use_case.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/dream_interview_repository.dart';

class ConvertVoiceToText extends UseCase<String, AudioDataParams> {
  final DreamInterviewRepository repository;

  ConvertVoiceToText(this.repository);

  @override
  Future<Either<Failure, String>> call(AudioDataParams params) {
    return repository.convertVoiceToText(params.audioData);
  }
}

class AudioDataParams extends Equatable {
  final List<int> audioData;

  const AudioDataParams({
    required this.audioData,
  });

  @override
  List<Object?> get props => [audioData];
}
