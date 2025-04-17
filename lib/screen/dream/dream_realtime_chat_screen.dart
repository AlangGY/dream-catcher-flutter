import 'dart:math';

import 'package:dream_catcher/ui/ui_export.dart';
import 'package:flutter/material.dart';

class DreamRealtimeChatScreen extends StatefulWidget {
  const DreamRealtimeChatScreen({Key? key}) : super(key: key);

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
            icon: Icon(Icons.file_download_outlined,
                color: Theme.of(context).primaryColor),
            onPressed: () {
              // 저장 기능
            },
          ),
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
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                              blurRadius: 16,
                              spreadRadius: 4,
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).primaryColor.withOpacity(0.2),
                              Theme.of(context).primaryColor.withOpacity(0.3),
                              Theme.of(context).primaryColor.withOpacity(0.4),
                            ],
                            stops: [
                              0.2,
                              0.5 +
                                  0.1 *
                                      sin(_animationController.value * 2 * pi),
                              0.8,
                            ],
                          ),
                        ),
                        child: _isListening
                            ? _buildAnimatedWaves()
                            : Icon(
                                Icons.cloud,
                                size: 80,
                                color: Colors.white.withOpacity(0.7),
                              ),
                      );
                    },
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
                GestureDetector(
                  onTap: _toggleListening,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: _isListening
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (_isListening
                                  ? Colors.red
                                  : Theme.of(context).primaryColor)
                              .withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                // 닫기 버튼
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close,
                        color: Theme.of(context).primaryColor.withOpacity(0.5)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedWaves() {
    return CustomPaint(
      painter: WavePainter(
        animation: _animationController,
      ),
      child: Container(),
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;

  WavePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = min(centerX, centerY);

    for (int i = 0; i < 3; i++) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(0.3 - (i * 0.1))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      final progress = (animation.value + (i * 0.2)) % 1.0;
      final currentRadius = radius * progress * 1.2;

      if (currentRadius > 0) {
        canvas.drawCircle(
          Offset(centerX, centerY),
          currentRadius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
