import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DreamDeleteDialog extends StatelessWidget {
  const DreamDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('꿈 기록 삭제', style: AppTextStyles.heading2(context)),
      content: const Text(
        '이 꿈 기록을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.',
        style: AppTextStyles.body,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            // 삭제 로직 처리
            context.pop();
            context.pop();
          },
          child: const Text('삭제', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
