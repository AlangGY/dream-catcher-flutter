import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart'
    as entity;
import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class DreamListScreen extends StatefulWidget {
  const DreamListScreen({super.key});

  @override
  State<DreamListScreen> createState() => _DreamListScreenState();
}

class _DreamListScreenState extends State<DreamListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late entity.DreamList _dreamList;
  late List<entity.DreamListItem> _filteredDreams;
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['전체', '최근', '감정별', '태그별'];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _dreamList = entity.DreamList.sample();
    _filteredDreams = _dreamList.dreams;
  }

  void _filterDreams(String query) {
    setState(() {
      _filteredDreams = _dreamList.dreams.where((dream) {
        final titleLower = dream.title.toLowerCase();
        final contentLower = dream.content.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) ||
            contentLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      appBar: CommonAppBar(
        title: '꿈 기록',
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
            onPressed: _showSearchDialog,
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
            },
          ),
          Expanded(
            child: _filteredDreams.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredDreams.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final dream = _filteredDreams[index];
                      return DreamListItem(
                        dream: dream,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // 새 꿈 기록 화면으로 이동
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      message: '아직 기록된 꿈이 없습니다.\n새로운 꿈을 기록해보세요!',
      icon: Icons.nights_stay_outlined,
      actionLabel: '꿈 기록하기',
      onAction: () {
        // 새 꿈 기록 화면으로 이동
      },
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => DreamSearchDialog(
        onSearch: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
