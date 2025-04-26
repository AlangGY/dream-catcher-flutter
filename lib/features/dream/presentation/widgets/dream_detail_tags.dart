import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';

class DreamDetailTags extends StatelessWidget {
  final List<String> tags;
  final Color tagColor;

  const DreamDetailTags({
    super.key,
    required this.tags,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: '태그',
          padding: EdgeInsets.only(bottom: 12),
        ),
        TagsWrap(
          tags: tags,
          tagColor: tagColor,
        ),
      ],
    );
  }
}
