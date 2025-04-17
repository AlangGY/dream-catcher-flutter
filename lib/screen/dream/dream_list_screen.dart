import 'package:dream_catcher/ui/ui_export.dart';
import 'package:dream_catcher/widgets/common_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class DreamListScreen extends StatefulWidget {
  final bool showBottomNav = true;
  const DreamListScreen({Key? key}) : super(key: key);

  @override
  State<DreamListScreen> createState() => _DreamListScreenState();
}

class _DreamListScreenState extends State<DreamListScreen> {
  // 임시 데이터
  final List<Map<String, dynamic>> dreams = [
    {
      'title': '바다에서 수영하는 꿈',
      'date': '2023년 5월 15일',
      'mood': '평화로움',
      'color': const Color(0xFF6699CC),
      'content': '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
    },
    {
      'title': '하늘을 나는 꿈',
      'date': '2023년 5월 12일',
      'mood': '신남',
      'color': const Color(0xFF66CCCC),
      'content': '높은 건물 위에서 갑자기 하늘로 날아오르는 꿈을 꾸었다...',
    },
    {
      'title': '시험에 늦는 꿈',
      'date': '2023년 5월 8일',
      'mood': '불안함',
      'color': const Color(0xFFCC6666),
      'content': '중요한 시험에 늦게 도착해서 허둥지둥하는 꿈이었다...',
    },
    {
      'title': '옛 친구들과의 만남',
      'date': '2023년 5월 5일',
      'mood': '그리움',
      'color': const Color(0xFF9966CC),
      'content': '오랜만에 초등학교 친구들과 함께 놀고 있었다...',
    },
    {
      'title': '새로운 집으로 이사',
      'date': '2023년 5월 1일',
      'mood': '설렘',
      'color': const Color(0xFF66CC99),
      'content': '넓고 아름다운 집으로 이사하는 꿈이었다...',
    },
    {
      'title': '미지의 도시에서 길 잃음',
      'date': '2023년 4월 27일',
      'mood': '혼란스러움',
      'color': const Color(0xFFCC9966),
      'content': '한 번도 가본 적 없는 도시에서 길을 잃고 헤매고 있었다...',
    },
    {
      'title': '공연장에서의 무대',
      'date': '2023년 4월 23일',
      'mood': '긴장됨',
      'color': const Color(0xFFCC66CC),
      'content': '많은 관객들 앞에서 공연을 하는 꿈이었다...',
    },
  ];

  int _selectedFilterIndex = 0;
  final List<String> _filters = ['전체', '최근', '감정별', '태그별'];
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDreams = dreams;

    // 검색어 필터링
    if (_searchQuery.isNotEmpty) {
      filteredDreams = dreams
          .where((dream) =>
              dream['title']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              dream['content']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      appBar: CommonAppBar(
        title: '꿈 기록',
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterTabs(),
          Expanded(
            child: filteredDreams.isEmpty
                ? _buildEmptyState()
                : _buildDreamList(filteredDreams),
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // 새 꿈 기록 화면으로 이동
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return CommonCard(
      width: double.infinity,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(_filters.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ChoiceChip(
                label: Text(_filters[index]),
                selected: _selectedFilterIndex == index,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedFilterIndex = index;
                    });
                  }
                },
                selectedColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: _selectedFilterIndex == index
                      ? Colors.white
                      : const Color(0xFF8080B2),
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: _selectedFilterIndex == index
                        ? Colors.transparent
                        : const Color(0xFFB2B2E5),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDreamList(List<Map<String, dynamic>> dreamList) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: dreamList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final dream = dreamList[index];
        return _buildDreamItem(dream);
      },
    );
  }

  Widget _buildDreamItem(Map<String, dynamic> dream) {
    return GestureDetector(
      onTap: () {
        // 꿈 상세 화면으로 이동
        Navigator.pushNamed(context, '/dream_detail');
      },
      child: CommonCard(
        child: Row(
          children: [
            Container(
              width: 6,
              height: 120,
              decoration: BoxDecoration(
                color: dream['color'] as Color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dream['title'] as String,
                    style: AppTextStyles.heading3(context),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: dream['color'] as Color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dream['date'] as String,
                        style: AppTextStyles.captionSmall,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.emoji_emotions_outlined,
                        size: 12,
                        color: dream['color'] as Color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dream['mood'] as String,
                        style: AppTextStyles.captionSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dream['content'] as String,
                    style: AppTextStyles.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
          ],
        ),
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
      builder: (context) => AlertDialog(
        title: Text('꿈 검색', style: AppTextStyles.heading2(context)),
        content: TextField(
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요',
            hintStyle: AppTextStyles.caption,
            prefixIcon:
                Icon(Icons.search, color: Theme.of(context).primaryColor),
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
            setState(() {
              _searchQuery = value;
            });
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '취소',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              // 검색 실행
              Navigator.pop(context);
            },
            child: Text(
              '검색',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
