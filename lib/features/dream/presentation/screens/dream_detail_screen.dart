import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_detail_bloc.dart';
import 'package:dream_catcher/injection_container.dart';
import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class DreamDetailScreen extends StatelessWidget {
  final String dreamId;

  const DreamDetailScreen({super.key, required this.dreamId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<DreamDetailBloc>()..add(LoadDreamEvent(dreamId: dreamId)),
      child: Scaffold(
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
        body: BlocBuilder<DreamDetailBloc, DreamDetailState>(
          builder: (context, state) {
            if (state is DreamDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DreamDetailLoaded) {
              return _buildDreamDetail(context, state.dream);
            } else if (state is DreamDetailError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: Text('꿈 정보를 불러올 수 없습니다.'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDreamDetail(BuildContext context, DreamDetail dream) {
    return SingleChildScrollView(
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
    );
  }
}
