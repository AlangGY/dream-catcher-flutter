import 'package:flutter/material.dart';

/// 태그를 표시하기 위한 공통 칩 위젯
class TagChip extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback? onTap;
  final bool showHashtag;

  const TagChip({
    super.key,
    required this.label,
    this.color,
    this.onTap,
    this.showHashtag = true,
  });

  @override
  Widget build(BuildContext context) {
    final tagColor = color ?? Theme.of(context).primaryColor;
    final displayText = showHashtag ? '#$label' : label;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: tagColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          displayText,
          style: TextStyle(
            fontSize: 14,
            color: tagColor,
          ),
        ),
      ),
    );
  }
}

/// 여러 태그를 표시하기 위한 래퍼 위젯
class TagsWrap extends StatelessWidget {
  final List<String> tags;
  final Color? tagColor;
  final Function(String)? onTagTap;
  final bool showHashtag;

  const TagsWrap({
    super.key,
    required this.tags,
    this.tagColor,
    this.onTagTap,
    this.showHashtag = true,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return TagChip(
          label: tag,
          color: tagColor,
          onTap: onTagTap != null ? () => onTagTap!(tag) : null,
          showHashtag: showHashtag,
        );
      }).toList(),
    );
  }
}
