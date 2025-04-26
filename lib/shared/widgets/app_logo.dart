import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double logoSize;
  final double titleFontSize;
  final double subtitleFontSize;
  final bool showSubtitle;

  const AppLogo({
    super.key,
    this.logoSize = 120,
    this.titleFontSize = 32,
    this.subtitleFontSize = 16,
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: const Color(0xFF6666CC),
            borderRadius: BorderRadius.circular(logoSize * 0.25),
          ),
          child: Icon(
            Icons.nightlight_round,
            size: logoSize * 0.58,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Dream Catcher',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4D4D99),
          ),
        ),
        if (showSubtitle) ...[
          const SizedBox(height: 16),
          Text(
            '꿈을 기록하고 관리하는 가장 쉬운 방법',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subtitleFontSize,
              color: const Color(0xFF8080B2),
            ),
          ),
        ],
      ],
    );
  }
}
