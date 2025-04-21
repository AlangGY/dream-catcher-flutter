import 'dart:math';

import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

class DreamThinkingIndicator extends StatelessWidget {
  final AnimationController animationController;

  const DreamThinkingIndicator({
    super.key,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
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
            animation: animationController,
            builder: (context, child) {
              return CommonCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                width: null,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Row(
                  children: [
                    _buildDot(context, 0),
                    const SizedBox(width: 4),
                    _buildDot(context, 0.2),
                    const SizedBox(width: 4),
                    _buildDot(context, 0.4),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDot(BuildContext context, double delay) {
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
    final double t = (animationController.value + delay) % 1.0;
    return (sin(t * 6.28) + 1.0) / 2.0;
  }
}
