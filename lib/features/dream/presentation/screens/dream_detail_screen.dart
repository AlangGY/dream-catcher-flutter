import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class DreamDetailScreen extends StatefulWidget {
  final String dreamId;

  const DreamDetailScreen({super.key, required this.dreamId});

  @override
  State<DreamDetailScreen> createState() => _DreamDetailScreenState();
}

class _DreamDetailScreenState extends State<DreamDetailScreen> {
  late final DreamDetail dream;

  @override
  void initState() {
    super.initState();
    // 임시로 샘플 데이터 사용
    // 나중에 widget.dreamId를 사용하여 실제 꿈 데이터를 가져와야 함
    dream = DreamDetail.sample();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      appBar: CommonAppBar(
        title: '',
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            onPressed: () {
              // 꿈 편집 화면으로 이동
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline,
                color: Theme.of(context).primaryColor),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const DreamDeleteDialog(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DreamDetailHeader(dream: dream),
            const SizedBox(height: 24),
            DreamDetailContent(content: dream.content),
            const SizedBox(height: 24),
            DreamDetailTags(
              tags: dream.tags,
              tagColor: dream.color,
            ),
            const SizedBox(height: 24),
            DreamDetailInfo(dream: dream),
            const SizedBox(height: 24),
            DreamDetailInterpretation(
              interpretation: dream.interpretation,
            ),
          ],
        ),
      ),
    );
  }
}
