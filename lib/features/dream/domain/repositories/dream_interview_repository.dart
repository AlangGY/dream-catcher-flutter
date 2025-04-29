import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/dream_interview.dart';

abstract class DreamInterviewRepository {
  /// 새로운 인터뷰를 시작합니다.
  Future<Either<Failure, DreamInterview>> startInterview();

  /// 인터뷰에 새 메시지를 추가합니다.
  Future<Either<Failure, DreamInterview>> answerMessage(
      String interviewId, SpeakerType speakerType, String content);

  /// 인터뷰를 완료하고 꿈 기록으로 저장합니다.
  Future<Either<Failure, Unit>> completeInterview(String interviewId);

  /// 음성을 텍스트로 변환합니다.
  Future<Either<Failure, String>> convertVoiceToText(List<int> audioData);

  /// 진행 중인 인터뷰를 가져옵니다.
  Future<Either<Failure, DreamInterview>> getCurrentInterview(
      String interviewId);
}
