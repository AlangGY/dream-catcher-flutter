import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/dream_detail.dart';
import '../bloc/dream_detail_bloc.dart';

class DreamDetailPage extends StatelessWidget {
  final String dreamId;

  const DreamDetailPage({super.key, required this.dreamId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<DreamDetailBloc>()..add(LoadDreamEvent(dreamId: dreamId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('꿈 상세 정보'),
        ),
        body: BlocBuilder<DreamDetailBloc, DreamDetailState>(
          builder: (context, state) {
            if (state is DreamDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DreamDetailLoaded) {
              return _buildDreamDetail(context, state.dream);
            } else if (state is DreamDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('꿈을 불러오세요'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildDreamDetail(BuildContext context, DreamDetail dream) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: dream.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            dream.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '날짜: ${_formatDate(dream.date)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 16),
              Text(
                '감정: ${dream.mood}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Divider(height: 32),
          Text(
            '꿈 내용',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(dream.content),
          const Divider(height: 32),
          Text(
            '태그',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: dream.tags
                .map((tag) => Chip(
                      label: Text(tag),
                      backgroundColor: dream.color.withOpacity(0.3),
                    ))
                .toList(),
          ),
          if (dream.people.isNotEmpty && dream.people.first != '없음') ...[
            const Divider(height: 32),
            Text(
              '등장인물',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: dream.people
                  .map((person) => Chip(
                        label: Text(person),
                        backgroundColor: Colors.grey.withOpacity(0.3),
                      ))
                  .toList(),
            ),
          ],
          const Divider(height: 32),
          _buildRatingRow('선명도', dream.clearness),
          const SizedBox(height: 16),
          _buildRatingRow('자각몽 여부', dream.lucidity),
          if (dream.symbolism.isNotEmpty) ...[
            const Divider(height: 32),
            Text(
              '상징',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(dream.symbolism),
          ],
          if (dream.interpretation.isNotEmpty) ...[
            const Divider(height: 32),
            Text(
              '해석',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(dream.interpretation),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String label, int rating) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: index < rating ? Colors.amber : Colors.grey,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }
}
