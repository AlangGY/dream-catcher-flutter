import 'package:dream_catcher/ui/text_styles.dart';
import 'package:flutter/material.dart';

/// 화면 내 섹션의 제목과 부가 액션을 표시하는 공통 위젯
class SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const SectionTitle({
    Key? key,
    required this.title,
    this.trailing,
    this.padding = const EdgeInsets.only(bottom: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.heading2(context),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// '모두 보기' 버튼이 포함된 섹션 제목 위젯
class SectionTitleWithMore extends StatelessWidget {
  final String title;
  final String moreText;
  final VoidCallback onMoreTap;
  final EdgeInsetsGeometry padding;

  const SectionTitleWithMore({
    Key? key,
    required this.title,
    this.moreText = '모두 보기',
    required this.onMoreTap,
    this.padding = const EdgeInsets.only(bottom: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionTitle(
      title: title,
      padding: padding,
      trailing: TextButton(
        onPressed: onMoreTap,
        child: Text(
          moreText,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
