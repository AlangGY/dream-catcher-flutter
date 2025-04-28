import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';

class DreamDetailInfo extends StatelessWidget {
  final DreamDetail dream;

  const DreamDetailInfo({
    super.key,
    required this.dream,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: '세부 정보',
          padding: EdgeInsets.only(bottom: 16),
        ),
        CommonCard(
          child: Column(
            children: [
              _buildDetailItem(
                context,
                '감정',
                Text(
                  dream.mood,
                  style: AppTextStyles.body,
                ),
              ),
              const Divider(),
              _buildDetailItem(
                context,
                '색상',
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: dream.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "#${dream.color.value.toRadixString(16).substring(2).padLeft(6, '0')}",
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(
      BuildContext context, String label, Widget valueChild) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyEmphasis(context),
          ),
          valueChild
        ],
      ),
    );
  }

  String _formatList(List<String> items) {
    if (items.isEmpty) return '없음';
    return items.join(', ');
  }
}
