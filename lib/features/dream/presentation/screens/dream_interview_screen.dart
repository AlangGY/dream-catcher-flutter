import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class DreamInterviewScreen extends StatefulWidget {
  const DreamInterviewScreen({super.key});

  @override
  State<DreamInterviewScreen> createState() => _DreamInterviewScreenState();
}

class _DreamInterviewScreenState extends State<DreamInterviewScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isRecording = false;
  bool _isAIThinking = false;
  late AnimationController _animationController;
  bool _isInitializing = true;

  // AI 프롬프트 및 대화 시나리오
  final List<String> _aiPrompts = [
    "안녕하세요. 꿈 기록을 도와드릴 AI 인터뷰어입니다. 최근에 기억나는, 인상깊었던 꿈에 대해 이야기해 주세요.",
    "그 꿈에서 어떤 감정을 느끼셨나요?",
    "꿈에서 특별히 인상깊었던 장소나 물체가 있었나요?",
    "꿈에 등장한 인물들이 있었다면 누구였는지 말씀해주세요.",
    "그 꿈이 현실의 어떤 부분과 연관되어 있다고 생각하시나요?",
    "꿈의 내용을 요약해서 한 번 더 말씀해주시겠어요?"
  ];
  int _currentPromptIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.repeat();

    // 초기 AI 메시지 추가 (약간의 지연 후)
    Future.delayed(const Duration(milliseconds: 1000), () {
      _addMessage(_aiPrompts[_currentPromptIndex], false);
      setState(() {
        _currentPromptIndex++;
        _isInitializing = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addMessage(String text, bool isUserMessage) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUserMessage: isUserMessage,
      ));
    });

    // 메시지가 추가된 후 스크롤
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    _addMessage(text, true);
    setState(() {
      _isAIThinking = true;
    });

    // AI 응답 시뮬레이션 (실제로는 AI 모델에 요청을 보내야 함)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      setState(() {
        _isAIThinking = false;
      });

      if (_currentPromptIndex < _aiPrompts.length) {
        _addMessage(_aiPrompts[_currentPromptIndex], false);
        setState(() {
          _currentPromptIndex++;
        });
      } else {
        // 모든 프롬프트가 끝나면 마무리 메시지
        _addMessage(
          "감사합니다. 꿈 분석을 완료했습니다. 꿈 기록을 저장하시겠습니까?",
          false,
        );
      }
    });
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;

      if (!_isRecording) {
        // 녹음 중지 시 - 실제로는 음성 인식 결과를 가져와야 함
        // 여기서는 테스트용 텍스트로 대체
        String recognizedText =
            "저는 바다에서 수영하는 꿈을 꾸었어요. 파란 바다였고 물고기들과 함께 헤엄치고 있었습니다.";
        _handleSubmitted(recognizedText);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      appBar: CommonAppBar(
        title: 'AI 꿈 인터뷰',
        actions: [
          IconButton(
            icon:
                Icon(Icons.help_outline, color: Theme.of(context).primaryColor),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const DreamHelpDialog(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isInitializing
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : _buildChatList(),
          ),
          DreamInputArea(
            textController: _textController,
            onSubmitted: _handleSubmitted,
            isRecording: _isRecording,
            onRecordPressed: _toggleRecording,
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: _messages.length + (_isAIThinking ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isAIThinking) {
          return DreamThinkingIndicator(
            animationController: _animationController,
          );
        }

        return _messages[index];
      },
    );
  }
}
