import 'dart:math';

import 'package:dream_catcher/features/dream/data/data-sources/dream_interview_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_interview_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:uuid/uuid.dart';

class DreamInterviewMockDataSource implements DreamInterviewDataSource {
  // ignore: unused_field
  static const _modelFactory = DreamInterviewModelFactory();
  // ignore: unused_field
  static const _messageFactory = DreamInterviewMessageModelFactory();

  final Map<String, DreamInterviewModel> _activeInterviews = {};
  final Uuid _uuid;

  // 모의 인터뷰 진행을 위한 기본 질문 목록
  final List<String> _defaultQuestions = [
    "안녕하세요. 꿈 기록을 도와드릴 AI 인터뷰어입니다. 최근에 기억나는, 인상깊었던 꿈에 대해 이야기해 주세요.",
    "그 꿈에서 어떤 감정을 느끼셨나요?",
    "꿈에서 특별히 인상깊었던 장소나 물체가 있었나요?",
    "꿈에 등장한 인물들이 있었다면 누구였는지 말씀해주세요.",
    "그 꿈이 현실의 어떤 부분과 연관되어 있다고 생각하시나요?",
    "꿈의 내용을 요약해서 한 번 더 말씀해주시겠어요?",
    "감사합니다. 꿈 분석을 완료했습니다. 꿈 기록을 저장하시겠습니까?"
  ];

  DreamInterviewMockDataSource({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  @override
  Future<DreamInterviewModel> startInterview() async {
    // 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 500));

    final String id = _uuid.v4();
    final DateTime now = DateTime.now();

    // 첫 번째 메시지를 봇이 보내는 형태로 시작
    final message = DreamInterviewMessageModel(
      id: _uuid.v4(),
      speakerType: SpeakerType.bot,
      content: _defaultQuestions[0],
      timestamp: now,
    );

    final interview = DreamInterviewModel(
      id: id,
      messages: [message],
      date: now,
      isCompleted: false,
    );

    _activeInterviews[id] = interview;
    return interview;
  }

  @override
  Future<DreamInterviewModel> addMessage(
      String interviewId, SpeakerType speakerType, String content) async {
    // 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 300));

    if (!_activeInterviews.containsKey(interviewId)) {
      throw Exception('인터뷰를 찾을 수 없습니다: $interviewId');
    }

    final currentInterview = _activeInterviews[interviewId]!;
    final message = DreamInterviewMessageModel(
      id: _uuid.v4(),
      speakerType: speakerType,
      content: content,
      timestamp: DateTime.now(),
    );

    final updatedMessages = [...currentInterview.messages, message];
    final updatedInterview = DreamInterviewModel(
      id: currentInterview.id,
      messages: updatedMessages,
      date: currentInterview.date,
      isCompleted: currentInterview.isCompleted,
    );

    _activeInterviews[interviewId] = updatedInterview;
    return updatedInterview;
  }

  @override
  Future<void> completeInterview(String interviewId) async {
    // 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_activeInterviews.containsKey(interviewId)) {
      throw Exception('인터뷰를 찾을 수 없습니다: $interviewId');
    }

    final currentInterview = _activeInterviews[interviewId]!;
    final updatedInterview = DreamInterviewModel(
      id: currentInterview.id,
      messages: currentInterview.messages,
      date: currentInterview.date,
      isCompleted: true,
    );

    _activeInterviews[interviewId] = updatedInterview;
    // 실제로는 여기서 꿈 저장 로직이 들어갈 수 있음
  }

  @override
  Future<String> convertVoiceToText(List<int> audioData) async {
    // 실제 음성 처리는 하지 않고, 모의 텍스트 응답 제공
    await Future.delayed(const Duration(milliseconds: 1000));

    // 모의 음성 인식 응답
    final List<String> mockResponses = [
      "저는 바다에서 수영하는 꿈을 꾸었어요. 파란 바다였고 물고기들과 함께 헤엄치고 있었습니다.",
      "꿈에서 공중에 둥둥 떠다니고 있었어요. 마치 중력이 없는 것처럼 자유롭게 움직였습니다.",
      "거대한 성 안에서 미로를 헤매는 꿈이었어요. 계속 출구를 찾으려고 했지만 복잡한 길에 막혔습니다.",
      "행복했어요. 마치 모든 걱정이 사라진 것 같은 느낌이었습니다.",
    ];

    return mockResponses[Random().nextInt(mockResponses.length)];
  }

  @override
  Future<DreamInterviewModel> getCurrentInterview(String interviewId) async {
    // 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 300));

    if (!_activeInterviews.containsKey(interviewId)) {
      throw Exception('인터뷰를 찾을 수 없습니다: $interviewId');
    }

    return _activeInterviews[interviewId]!;
  }

  @override
  Future<String> getBotResponse(String interviewId,
      List<DreamInterviewMessageModel> previousMessages) async {
    // 네트워크 지연 시뮬레이션 (API 호출 시뮬레이션)
    await Future.delayed(const Duration(milliseconds: 800));

    if (!_activeInterviews.containsKey(interviewId)) {
      throw Exception('인터뷰를 찾을 수 없습니다: $interviewId');
    }

    // 봇 메시지 수를 카운트하여 다음 기본 질문을 선택
    int botMessageCount = previousMessages
        .where((message) => message.speakerType == SpeakerType.bot)
        .length;

    // 모든 기본 질문을 이미 사용한 경우
    if (botMessageCount >= _defaultQuestions.length) {
      return "다른 질문이 있으신가요? 또는 인터뷰를 마치시겠습니까?";
    }

    return _defaultQuestions[botMessageCount];
  }
}
