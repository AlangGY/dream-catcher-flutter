import 'package:dream_catcher/features/dream/data/models/dream_interview_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';

abstract class DreamInterviewDataSource {
  /// 새 인터뷰 세션을 시작합니다.
  Future<DreamInterviewModel> startInterview();

  /// 인터뷰에 새 메시지를 추가합니다.
  Future<DreamInterviewModel> answerMessage(
      String interviewId, SpeakerType speakerType, String content);

  /// 인터뷰를 완료하고 꿈 기록으로 저장합니다.
  Future<void> completeInterview(String interviewId);

  /// 음성을 텍스트로 변환합니다.
  Future<String> convertVoiceToText(List<int> audioData);

  /// 진행 중인 인터뷰를 가져옵니다.
  Future<DreamInterviewModel> getCurrentInterview(String interviewId);
}
