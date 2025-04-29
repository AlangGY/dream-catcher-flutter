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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: CommonCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _progressItem('선명도', dream.clarity, 5, context),
              const Divider(height: 28),
              _progressItem('명료함', dream.vividness, 5, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowItem(String label, String value, BuildContext context,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.bodyEmphasis(context)
                .copyWith(color: Colors.grey[600])),
        Text(
          value,
          style: isBold
              ? AppTextStyles.bodyEmphasis(context).copyWith(
                  fontWeight: FontWeight.bold, color: Colors.indigo[700])
              : AppTextStyles.body.copyWith(color: Colors.indigo[700]),
        ),
      ],
    );
  }

  Widget _progressItem(String label, int value, int max, BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 60,
            child: Text(label, style: AppTextStyles.bodyEmphasis(context))),
        Text(
          '$value/$max',
          style: AppTextStyles.body.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: LinearProgressIndicator(
            value: value / max,
            backgroundColor: Colors.indigo[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo[400]!),
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
