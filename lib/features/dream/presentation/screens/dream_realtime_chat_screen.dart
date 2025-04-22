import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class DreamRealtimeChatScreen extends StatefulWidget {
  const DreamRealtimeChatScreen({super.key});

  @override
  State<DreamRealtimeChatScreen> createState() =>
      _DreamRealtimeChatScreenState();
}

class _DreamRealtimeChatScreenState extends State<DreamRealtimeChatScreen>
    with SingleTickerProviderStateMixin {
  bool _isListening = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        // 실제 음성 인식 시작
        _startListening();
      } else {
        // 실제 음성 인식 중지
        _stopListening();
      }
    });
  }

  void _startListening() {
    // 실제 음성 인식 로직 구현
    // 테스트용 메시지
    setState(() {});
  }

  void _stopListening() {
    // 실제 음성 인식 중지 로직 구현
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CommonAppBar(
        title: '',
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Theme.of(context).primaryColor),
            onPressed: () {
              // 설정 기능
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 파란색 원형 구름 이미지 (애니메이션)
                  DreamAnimatedCloud(
                    animationController: _animationController,
                    isListening: _isListening,
                  ),
                  // 음성 인식 텍스트
                ],
              ),
            ),
          ),
          // 하단 버튼 영역
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 마이크 버튼
                const SizedBox(width: 80),
                DreamMicButton(
                  isListening: _isListening,
                  onTap: _toggleListening,
                ),
                const SizedBox(width: 30),
                // 닫기 버튼
                const DreamCloseButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
