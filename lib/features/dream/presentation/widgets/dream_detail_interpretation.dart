import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

class DreamDetailInterpretation extends StatelessWidget {
  final String interpretation;

  const DreamDetailInterpretation({
    super.key,
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: '해석',
          padding: EdgeInsets.only(bottom: 16),
        ),
        CommonCard(
          child: Text(
            interpretation,
            style: AppTextStyles.body,
          ),
        ),
      ],
    );
  }
}
