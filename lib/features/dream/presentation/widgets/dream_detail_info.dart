import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/shared/common-ui/common-ui.dart';
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
              _buildDetailItem(context, '등장인물', _formatList(dream.people)),
              const Divider(),
              _buildDetailItem(context, '선명도', '${dream.clearness}/5'),
              const Divider(),
              _buildDetailItem(context, '자각몽 여부', '${dream.lucidity}/5'),
              const Divider(),
              _buildDetailItem(context, '상징', dream.symbolism),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyEmphasis(context),
          ),
          Text(
            value,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  String _formatList(List<String> items) {
    if (items.isEmpty) return '없음';
    return items.join(', ');
  }
}
