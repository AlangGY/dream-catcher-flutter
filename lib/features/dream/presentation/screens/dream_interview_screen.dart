import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_interview_bloc.dart';
import 'package:dream_catcher/injection_container.dart';
import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class DreamInterviewScreen extends StatelessWidget {
  const DreamInterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DreamInterviewBloc>(
      create: (_) => sl<DreamInterviewBloc>(),
      child: _DreamInterviewContent(),
    );
  }
}

class _DreamInterviewContent extends StatefulWidget {
  @override
  State<_DreamInterviewContent> createState() => _DreamInterviewContentState();
}

class _DreamInterviewContentState extends State<_DreamInterviewContent>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  bool _isRecording = false;

  DreamInterview? _currentInterview;
  List<DreamInterviewMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.repeat();

    // 인터뷰 시작 (약간의 지연을 줘서 BuildContext가 준비된 후 실행)
    Future.microtask(() {
      if (mounted) {
        context.read<DreamInterviewBloc>().add(const StartInterviewEvent());
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty || _currentInterview == null) return;

    _textController.clear();

    // 사용자 메시지 추가
    context.read<DreamInterviewBloc>().add(AddMessageEvent(
          interviewId: _currentInterview!.id,
          speakerType: SpeakerType.me,
          content: text,
        ));

    // BlocConsumer에서 메시지 추가가 완료되면 봇 응답을 요청하도록 변경
    // 별도로 봇 응답 요청하지 않음
  }

  // 사용자 메시지가 추가된 후 봇 응답을 요청하는 메서드
  void _requestBotResponse() {
    if (_currentInterview != null) {
      context.read<DreamInterviewBloc>().add(GetBotResponseEvent(
            interviewId: _currentInterview!.id,
            previousMessages: _messages,
          ));
    }
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;

      if (!_isRecording && _currentInterview != null) {
        // 녹음 중지 시 음성 데이터를 텍스트로 변환 요청
        // 실제 구현에서는 음성 데이터를 캡처하여 전달
        // 현재는 더미 데이터 사용
        context.read<DreamInterviewBloc>().add(
              ConvertVoiceToTextEvent(audioData: [1, 2, 3, 4, 5]),
            );
      }
    });
  }

  void _completeInterview() {
    if (_currentInterview != null) {
      context.read<DreamInterviewBloc>().add(
            CompleteInterviewEvent(interviewId: _currentInterview!.id),
          );
    }
  }

  // 스크롤을 맨 아래로 이동
  void _scrollToBottom() {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DreamInterviewBloc, DreamInterviewState>(
      listener: (context, state) {
        if (state.interview != null) {
          setState(() {
            _currentInterview = state.interview;
            _messages = state.interview!.messages;
          });
        }
        if (state is DreamInterviewLoaded) {
          _scrollToBottom();

          // 마지막 메시지가 사용자 메시지인 경우 봇 응답 요청
          if (_messages.isNotEmpty &&
              _messages.last.speakerType == SpeakerType.me) {
            _requestBotResponse();
          }
        } else if (state is BotResponseLoadingState) {
          _scrollToBottom();
        } else if (state is VoiceToTextLoaded) {
          // 음성에서 변환된 텍스트를 입력으로 처리
          _handleSubmitted(state.text);
        } else if (state is VoiceToTextLoadingState &&
            state.interview != null) {
        } else if (state is DreamInterviewBotResponseLoaded) {
        } else if (state is DreamInterviewCompleted) {
          // 인터뷰 완료 후 처리 (예: 다음 화면으로 이동)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('인터뷰가 완료되었습니다.')),
          );
          Navigator.of(context).pop();
        } else if (state is DreamInterviewError) {
          // 오류 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        // 초기 로딩 상태인지 확인
        final bool isInitialLoading = state is InitialLoadingState ||
            state is DreamInterviewInitial ||
            _currentInterview == null;

        // 봇이 응답 중인지 확인
        final bool isBotThinking = state is BotResponseLoadingState;

        // 음성이 인식 중인지 확인
        final bool isVoiceRecognizing = state is VoiceToTextLoadingState;

        return Scaffold(
          backgroundColor: const Color(0xFFF2F2FF),
          appBar: CommonAppBar(
            title: 'AI 꿈 인터뷰',
            actions: [
              IconButton(
                icon: Icon(Icons.help_outline,
                    color: Theme.of(context).primaryColor),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const DreamHelpDialog(),
                  );
                },
              ),
              if (_messages.isNotEmpty)
                IconButton(
                  icon:
                      Icon(Icons.check, color: Theme.of(context).primaryColor),
                  onPressed: _completeInterview,
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: isInitialLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 16),
                            const Text('인터뷰를 불러오는 중...'),
                          ],
                        ),
                      )
                    : _buildChatList(
                        isBotThinking: isBotThinking,
                        isVoiceRecognizing: isVoiceRecognizing,
                      ),
              ),
              DreamInputArea(
                textController: _textController,
                onSubmitted: _handleSubmitted,
                isRecording: _isRecording || isVoiceRecognizing,
                onRecordPressed: _toggleRecording,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChatList({
    required bool isBotThinking,
    required bool isVoiceRecognizing,
  }) {
    // 상태 우선순위 결정
    // 음성 인식 > 봇 응답 > 메시지 추가 순으로 우선순위 지정
    Widget? additionalWidget;
    bool showAdditional = false;

    if (isVoiceRecognizing) {
      additionalWidget = _buildVoiceRecognizingIndicator();
      showAdditional = true;
    } else if (isBotThinking) {
      additionalWidget = DreamThinkingIndicator(
        animationController: _animationController,
      );
      showAdditional = true;
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: _messages.length + (showAdditional ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && showAdditional) {
          return additionalWidget!;
        }

        final message = _messages[index];
        return ChatMessage(
          text: message.content,
          isUserMessage: message.speakerType == SpeakerType.me,
        );
      },
    );
  }

  Widget _buildVoiceRecognizingIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mic, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(
            '음성을 인식하는 중...',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
