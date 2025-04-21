import 'package:dream_catcher/features/dream/presentation/bloc/dream_list_bloc.dart';
import 'package:dream_catcher/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'dream_empty_state.dart';
import 'dream_list_item.dart';

class DreamListContent extends StatelessWidget {
  final DreamListState state;
  final Function(BuildContext, String) onDeleteConfirm;

  const DreamListContent({
    Key? key,
    required this.state,
    required this.onDeleteConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is DreamListLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is DreamListLoaded) {
      final dreams = (state as DreamListLoaded).dreamList.dreams;

      if (dreams.isEmpty) {
        return DreamEmptyState(
          onActionPressed: () {
            context.push(AppRoutePath.dreamDetail);
          },
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dreams.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final dream = dreams[index];
          return DreamListItem(
            dream: dream,
            onTap: () {
              context.push(AppRoutePath.dreamDetail);
            },
            onDelete: () {
              onDeleteConfirm(context, dream.title);
            },
          );
        },
      );
    } else if (state is DreamListError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text((state as DreamListError).message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<DreamListBloc>().add(const GetDreamsEvent());
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    return DreamEmptyState(
      onActionPressed: () {
        context.push(AppRoutePath.dreamDetail);
      },
    );
  }
}
