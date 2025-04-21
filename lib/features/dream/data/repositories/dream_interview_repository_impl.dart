import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_interview_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_interview_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/features/dream/domain/repositories/dream_interview_repository.dart';

class DreamInterviewRepositoryImpl implements DreamInterviewRepository {
  final DreamInterviewDataSource dataSource;
  final DreamInterviewModelFactory _modelFactory;
  final DreamInterviewMessageModelFactory _messageFactory;

  DreamInterviewRepositoryImpl({
    required this.dataSource,
    DreamInterviewModelFactory? modelFactory,
    DreamInterviewMessageModelFactory? messageFactory,
  })  : _modelFactory = modelFactory ?? const DreamInterviewModelFactory(),
        _messageFactory =
            messageFactory ?? const DreamInterviewMessageModelFactory();

  @override
  Future<Either<Failure, DreamInterview>> startInterview() async {
    try {
      final result = await dataSource.startInterview();
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamInterview>> addMessage(
      String interviewId, SpeakerType speakerType, String content) async {
    try {
      final result =
          await dataSource.addMessage(interviewId, speakerType, content);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> completeInterview(String interviewId) async {
    try {
      await dataSource.completeInterview(interviewId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> convertVoiceToText(
      List<int> audioData) async {
    try {
      final result = await dataSource.convertVoiceToText(audioData);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamInterview>> getCurrentInterview(
      String interviewId) async {
    try {
      final result = await dataSource.getCurrentInterview(interviewId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getBotResponse(
      String interviewId, List<DreamInterviewMessage> previousMessages) async {
    try {
      // 도메인 엔티티를 데이터 모델로 변환
      final messageModels =
          previousMessages.map(_messageFactory.fromEntity).toList();

      final result =
          await dataSource.getBotResponse(interviewId, messageModels);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
