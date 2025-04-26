import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';

class DreamSummaryWidget extends StatelessWidget {
  const DreamSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: const EdgeInsets.all(20),
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.nightlight_round, color: Colors.white),
              SizedBox(width: 8),
              Text(
                '꿈 요약',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSummaryItem('기록한 꿈', '24'),
              _buildSummaryItem('이번 주', '3'),
              _buildSummaryItem('악몽', '5'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
