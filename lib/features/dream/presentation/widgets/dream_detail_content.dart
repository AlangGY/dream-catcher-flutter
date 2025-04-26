import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';

class DreamDetailContent extends StatelessWidget {
  final String content;

  const DreamDetailContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: const EdgeInsets.all(20),
      child: Text(
        content,
        style: AppTextStyles.body,
      ),
    );
  }
}
