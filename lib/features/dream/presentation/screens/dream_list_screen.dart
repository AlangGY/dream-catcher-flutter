import 'package:dream_catcher/features/dream/presentation/bloc/dream_list_bloc.dart';
import 'package:dream_catcher/injection_container.dart';
import 'package:dream_catcher/router.dart';
import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class DreamListScreen extends StatefulWidget {
  const DreamListScreen({super.key});

  @override
  State<DreamListScreen> createState() => _DreamListScreenState();
}

class _DreamListScreenState extends State<DreamListScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['전체', '최근', '감정별', '태그별'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DreamListBloc>()..add(const GetDreamsEvent()),
      child: BlocConsumer<DreamListBloc, DreamListState>(
        listener: (context, state) {
          if (state is DreamListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF2F2FF),
            appBar: CommonAppBar(
              title: '꿈 기록',
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon:
                      Icon(Icons.search, color: Theme.of(context).primaryColor),
                  onPressed: () => _showSearchDialog(context),
                ),
              ],
            ),
            body: Column(
              children: [
                DreamFilterTabs(
                  selectedFilterIndex: _selectedFilterIndex,
                  filters: _filters,
                  onFilterSelected: (index) {
                    setState(() {
                      _selectedFilterIndex = index;
                    });

                    // 필터 변경 시 이벤트 발생
                    if (index == 0) {
                      context
                          .read<DreamListBloc>()
                          .add(const ClearFiltersEvent());
                    } else if (index == 2) {
                      // 감정별 필터
                      _showMoodFilterDialog(context);
                    } else if (index == 1) {
                      // 최근 필터 (날짜)
                      _showDateFilterDialog(context);
                    }
                    // 다른 필터 타입들도 여기서 처리할 수 있음
                  },
                ),
                Expanded(
                  child: DreamListContent(
                    state: state,
                    onDeleteConfirm: _handleDeleteDream,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                context.push(AppRoutePath.dreamDetail);
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  void _handleDeleteDream(BuildContext context, String dreamId) {
    context.read<DreamListBloc>().add(DeleteDreamEvent(dreamId: dreamId));
  }

  void _showMoodFilterDialog(BuildContext context) {
    final moods = ['행복', '슬픔', '불안', '공포', '분노', '기쁨'];

    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('감정으로 필터링'),
        children: moods
            .map((mood) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    context
                        .read<DreamListBloc>()
                        .add(FilterDreamsByMoodEvent(mood: mood));
                  },
                  child: Text(mood),
                ))
            .toList(),
      ),
    );
  }

  void _showDateFilterDialog(BuildContext context) {
    // 오늘 날짜
    final now = DateTime.now();

    // 최근 1주일, 1개월, 3개월 옵션
    final options = [
      {
        'label': '최근 1주일',
        'startDate': now.subtract(const Duration(days: 7)),
        'endDate': now,
      },
      {
        'label': '최근 1개월',
        'startDate': DateTime(now.year, now.month - 1, now.day),
        'endDate': now,
      },
      {
        'label': '최근 3개월',
        'startDate': DateTime(now.year, now.month - 3, now.day),
        'endDate': now,
      },
    ];

    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('날짜로 필터링'),
        children: options
            .map((option) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    context.read<DreamListBloc>().add(
                          FilterDreamsByDateEvent(
                            startDate: option['startDate'] as DateTime,
                            endDate: option['endDate'] as DateTime,
                          ),
                        );
                  },
                  child: Text(option['label'] as String),
                ))
            .toList(),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => DreamSearchDialog(
        onSearch: (value) {
          if (value.isNotEmpty) {
            context.read<DreamListBloc>().add(SearchDreamsEvent(query: value));
          } else {
            context.read<DreamListBloc>().add(const GetDreamsEvent());
          }
        },
      ),
    );
  }
}

class DreamListContent extends StatelessWidget {
  final DreamListState state;
  final Function(BuildContext, String) onDeleteConfirm;

  const DreamListContent({
    super.key,
    required this.state,
    required this.onDeleteConfirm,
  });

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
              context.push(
                '${AppRoutePath.dreamDetail}/${dream.id}',
              );
            },
            onDelete: () {
              onDeleteConfirm(context, dream.id);
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

class DreamEmptyState extends StatelessWidget {
  final VoidCallback onActionPressed;

  const DreamEmptyState({
    super.key,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      message: '아직 기록된 꿈이 없습니다.\n새로운 꿈을 기록해보세요!',
      icon: Icons.nights_stay_outlined,
      actionLabel: '꿈 기록하기',
      onAction: onActionPressed,
    );
  }
}
