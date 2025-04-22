import 'dart:math';

import 'package:flutter/material.dart';

import 'wave_painter.dart';

class DreamAnimatedCloud extends StatelessWidget {
  final AnimationController animationController;
  final bool isListening;

  const DreamAnimatedCloud({
    super.key,
    required this.animationController,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
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
                0.5 + 0.1 * sin(animationController.value * 2 * pi),
                0.8,
              ],
            ),
          ),
          child: isListening
              ? _buildAnimatedWaves()
              : Icon(
                  Icons.cloud,
                  size: 80,
                  color: Colors.white.withOpacity(0.7),
                ),
        );
      },
    );
  }

  Widget _buildAnimatedWaves() {
    return CustomPaint(
      painter: WavePainter(
        animation: animationController,
      ),
      child: Container(),
    );
  }
}
