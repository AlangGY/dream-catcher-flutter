import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart'
    as entity;
import 'package:dream_catcher/router.dart';
import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DreamListItem extends StatelessWidget {
  final entity.DreamListItem dream;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const DreamListItem({
    super.key,
    required this.dream,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(dream.title),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('꿈 삭제'),
              content: const Text('이 꿈 기록을 삭제하시겠습니까?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    onDelete?.call();
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    '삭제',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: const Icon(
          Icons.delete_sweep_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
      child: GestureDetector(
        onTap: onTap ??
            () {
              context.push(AppRoutePath.dreamDetail);
            },
        child: CommonCard(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            dream.title,
                            style: AppTextStyles.heading3(context),
                          ),
                        ),
                      ],
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
      ),
    );
  }
}
