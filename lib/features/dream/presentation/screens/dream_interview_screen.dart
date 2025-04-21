import 'dart:math'; // sin 함수 사용을 위한 임포트

import 'package:dream_catcher/shared/common-ui/ui_export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DreamInterviewScreen extends StatefulWidget {
  const DreamInterviewScreen({Key? key}) : super(key: key);

  @override
  State<DreamInterviewScreen> createState() => _DreamInterviewScreenState();
}

class _DreamInterviewScreenState extends State<DreamInterviewScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
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
      setState(() {
        _messages.add(ChatMessage(
          text: _aiPrompts[_currentPromptIndex],
          isUserMessage: false,
        ));
        _currentPromptIndex++;
        _isInitializing = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUserMessage: true,
      ));
      _isAIThinking = true;
    });

    // AI 응답 시뮬레이션 (실제로는 AI 모델에 요청을 보내야 함)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      setState(() {
        _isAIThinking = false;

        if (_currentPromptIndex < _aiPrompts.length) {
          _messages.add(ChatMessage(
            text: _aiPrompts[_currentPromptIndex],
            isUserMessage: false,
          ));
          _currentPromptIndex++;
        } else {
          // 모든 프롬프트가 끝나면 마무리 메시지
          _messages.add(ChatMessage(
            text: "감사합니다. 꿈 분석을 완료했습니다. 꿈 기록을 저장하시겠습니까?",
            isUserMessage: false,
          ));
        }
      });
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
              // 도움말 표시
              _showHelpDialog();
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
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      reverse: false, // 새 메시지가 아래에 추가됨
      itemCount: _messages.length + (_isAIThinking ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isAIThinking) {
          return _buildThinkingIndicator();
        }
        return _messages[index];
      },
    );
  }

  Widget _buildThinkingIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.psychology,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CommonCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                borderRadius: 16,
                child: Row(
                  children: [
                    _buildDot(0),
                    const SizedBox(width: 4),
                    _buildDot(0.2),
                    const SizedBox(width: 4),
                    _buildDot(0.4),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDot(double delay) {
    final double size = 2.5 + 5.0 * _delayedSinAnimation(delay);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  double _delayedSinAnimation(double delay) {
    final double t = (_animationController.value + delay) % 1.0;
    return (sin(t * 6.28) + 1.0) / 2.0; // 0.0 ~ 1.0 사이 값
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '메시지 입력...',
                hintStyle: AppTextStyles.caption,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF2F2FF),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: _handleSubmitted,
            ),
          ),
          const SizedBox(width: 8),
          // 텍스트 전송 버튼
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
          // 음성 녹음 버튼
          FloatingActionButton(
            mini: true,
            backgroundColor:
                _isRecording ? Colors.red : Theme.of(context).primaryColor,
            elevation: 2,
            onPressed: _toggleRecording,
            child: Icon(
              _isRecording ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'AI 꿈 인터뷰 도움말',
            style: AppTextStyles.heading2(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. 마이크 버튼을 눌러 음성으로 꿈에 대해 이야기할 수 있습니다.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 8),
              Text(
                '2. 텍스트로 직접 입력하여 대화할 수도 있습니다.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 8),
              Text(
                '3. AI가 질문하는 내용에 따라 자유롭게 대답해주세요.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 8),
              Text(
                '4. 인터뷰가 끝나면 꿈 기록이 자동으로 저장됩니다.',
                style: AppTextStyles.body,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                '확인',
                style: AppTextStyles.bodyEmphasis(context),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isUserMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUserMessage) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.psychology,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: CommonCard(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              backgroundColor:
                  isUserMessage ? const Color(0xFFE1E1F9) : Colors.white,
              borderRadius: 16,
              child: Text(
                text,
                style: isUserMessage
                    ? AppTextStyles.bodyEmphasis(context)
                    : AppTextStyles.body,
              ),
            ),
          ),
          if (isUserMessage) ...[
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
