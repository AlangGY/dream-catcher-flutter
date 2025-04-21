import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DreamHelpDialog extends StatelessWidget {
  const DreamHelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'AI 꿈 인터뷰 도움말',
        style: AppTextStyles.heading2(context),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1. 마이크 버튼을 눌러 음성으로 꿈에 대해 이야기할 수 있습니다.',
            style: AppTextStyles.body,
          ),
          SizedBox(height: 8),
          Text(
            '2. 텍스트로 직접 입력하여 대화할 수도 있습니다.',
            style: AppTextStyles.body,
          ),
          SizedBox(height: 8),
          Text(
            '3. AI가 질문하는 내용에 따라 자유롭게 대답해주세요.',
            style: AppTextStyles.body,
          ),
          SizedBox(height: 8),
          Text(
            '4. 인터뷰가 끝나면 꿈 기록이 자동으로 저장됩니다.',
            style: AppTextStyles.body,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            '확인',
            style: AppTextStyles.bodyEmphasis(context),
          ),
        ),
      ],
    );
  }
}
