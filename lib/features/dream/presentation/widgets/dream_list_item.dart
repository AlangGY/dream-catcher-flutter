import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart'
    as entity;
import 'package:dream_catcher/router.dart';
import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DreamListItem extends StatelessWidget {
  final entity.DreamListItem dream;

  const DreamListItem({
    super.key,
    required this.dream,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutePath.dreamDetail);
      },
      child: CommonCard(
        child: Row(
          children: [
            Container(
              width: 6,
              height: 120,
              decoration: BoxDecoration(
                color: dream.color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dream.title,
                    style: AppTextStyles.heading3(context),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: dream.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('yyyy년 MM월 dd일').format(dream.date),
                        style: AppTextStyles.captionSmall,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.emoji_emotions_outlined,
                        size: 12,
                        color: dream.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dream.mood,
                        style: AppTextStyles.captionSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dream.content,
                    style: AppTextStyles.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
