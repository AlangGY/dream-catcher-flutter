import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DreamSearchDialog extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const DreamSearchDialog({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('꿈 검색', style: AppTextStyles.heading2(context)),
      content: TextField(
        decoration: InputDecoration(
          hintText: '검색어를 입력하세요',
          hintStyle: AppTextStyles.caption,
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        onChanged: (value) {
          onSearch(value);
          Navigator.pop(context);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text(
            '취소',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            '검색',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
