import 'dart:math';

import 'package:flutter/material.dart';

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
