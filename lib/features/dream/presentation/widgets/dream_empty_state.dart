import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

class DreamEmptyState extends StatelessWidget {
  final VoidCallback onActionPressed;

  const DreamEmptyState({
    Key? key,
    required this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      message: '아직 기록된 꿈이 없습니다.\n새로운 꿈을 기록해보세요!',
      icon: Icons.nights_stay_outlined,
      actionLabel: '꿈 기록하기',
      onAction: onActionPressed,
    );
  }
}
