import 'package:dream_catcher/router.dart';
import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecentDreamsWidget extends StatelessWidget {
  const RecentDreamsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWithMore(
          title: '최근 꿈',
          onMoreTap: () {
            context.go(AppRoutePath.dreamList);
          },
        ),
        const SizedBox(height: 12),
        _buildDreamCard(
          context,
          '바다에서 수영하는 꿈',
          '2023년 5월 15일',
          '평화로움',
          const Color(0xFF6699CC),
        ),
        const SizedBox(height: 12),
        _buildDreamCard(
          context,
          '하늘을 나는 꿈',
          '2023년 5월 12일',
          '신남',
          const Color(0xFF66CCCC),
        ),
      ],
    );
  }

  Widget _buildDreamCard(BuildContext context, String title, String date,
      String mood, Color color) {
    return CommonCard(
      child: Row(
        children: [
          Container(
            width: 6,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading3(context),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(date, style: AppTextStyles.captionSmall),
                    const SizedBox(width: 16),
                    Icon(Icons.emoji_emotions_outlined, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(mood, style: AppTextStyles.captionSmall),
                  ],
                ),
                const SizedBox(height: 12),
                TagsWrap(
                  tags: const ['바다', '수영'],
                  tagColor: color,
                  showHashtag: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
