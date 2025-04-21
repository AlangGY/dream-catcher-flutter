import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DreamDetailHeader extends StatelessWidget {
  final DreamDetail dream;

  const DreamDetailHeader({
    super.key,
    required this.dream,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: dream.color,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                dream.title,
                style: AppTextStyles.heading1(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: dream.color,
              ),
              const SizedBox(width: 6),
              Text(
                DateFormat('yyyy년 M월 d일').format(dream.date),
                style: AppTextStyles.caption,
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.emoji_emotions_outlined,
                size: 14,
                color: dream.color,
              ),
              const SizedBox(width: 6),
              Text(
                dream.mood,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
