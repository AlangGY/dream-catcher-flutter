import 'package:dream_catcher/router.dart';
import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DreamStatsWidget extends StatelessWidget {
  const DreamStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: '나의 꿈 통계',
        ),
        CommonCard(
          child: Column(
            children: [
              _buildStatRow(context, '가장 많이 꾸는 꿈', '바다에서의 경험 (32%)'),
              const Divider(),
              _buildStatRow(context, '가장 많은 감정', '평화로움 (45%)'),
              const Divider(),
              _buildStatRow(context, '이번 달 기록', '12회'),
              const Divider(),
              _buildStatRow(context, '평균 선명도', '3.2 / 5'),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.go(AppRoutePath.dreamAnalysis);
                  },
                  child: Text(
                    '자세한 분석 보기',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.caption),
          Text(
            value,
            style: AppTextStyles.bodyEmphasis(context),
          ),
        ],
      ),
    );
  }
}
