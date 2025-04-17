import 'package:dream_catcher/ui/ui_export.dart';
import 'package:dream_catcher/widgets/common_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class DreamAnalysisScreen extends StatefulWidget {
  final bool showBottomNav = true;
  const DreamAnalysisScreen({Key? key}) : super(key: key);

  @override
  State<DreamAnalysisScreen> createState() => _DreamAnalysisScreenState();
}

class _DreamAnalysisScreenState extends State<DreamAnalysisScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['주간', '월간', '연간'];

  // 샘플 데이터
  final Map<String, int> _emotionCounts = {
    '평화로움': 7,
    '불안함': 4,
    '기쁨': 3,
    '혼란스러움': 2,
    '공포': 1,
  };

  final Map<String, int> _dreamThemes = {
    '물/바다': 5,
    '비행': 4,
    '추격': 3,
    '시험': 3,
    '사랑하는 사람': 2,
    '기타': 8,
  };

  final List<int> _weeklyDreamCounts = [2, 1, 0, 3, 1, 2, 0];

  final List<Map<String, dynamic>> _insights = [
    {
      'title': '물과 관련된 꿈이 가장 많습니다',
      'description': '물은 감정이나 무의식을 상징할 수 있습니다. 최근 감정적인 변화가 있었나요?',
      'icon': Icons.water_drop,
      'color': Colors.blue,
    },
    {
      'title': '평화로운 꿈이 우세합니다',
      'description': '대체로 평화로운 꿈이 많은 것은 심리적 안정감을 나타낼 수 있습니다.',
      'icon': Icons.landscape,
      'color': Colors.green,
    },
    {
      'title': '월요일에 꿈을 가장 많이 기억합니다',
      'description': '주간 중 월요일에 꿈 기록이 가장 많습니다. 주말 휴식이 영향을 미쳤을 수 있습니다.',
      'icon': Icons.date_range,
      'color': Colors.purple,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      appBar: CommonAppBar(
        title: '꿈 분석',
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: const Color(0xFF8080B2),
          indicatorColor: Theme.of(context).primaryColor,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWeeklyAnalysis(),
          _buildMonthlyAnalysis(),
          _buildYearlyAnalysis(),
        ],
      ),
      bottomNavigationBar: const CommonBottomNavBar(),
    );
  }

  Widget _buildWeeklyAnalysis() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 16),
          _buildEmotionDistribution(),
          const SizedBox(height: 16),
          _buildDreamThemes(),
          const SizedBox(height: 16),
          _buildWeeklyPattern(),
          const SizedBox(height: 16),
          _buildInsights(),
        ],
      ),
    );
  }

  Widget _buildMonthlyAnalysis() {
    // 월간 분석 화면 (주간과 유사하지만 데이터만 다름)
    return Center(
      child: Text(
        '월간 분석 준비 중...',
        style: AppTextStyles.caption,
      ),
    );
  }

  Widget _buildYearlyAnalysis() {
    // 연간 분석 화면 (주간과 유사하지만 데이터만 다름)
    return Center(
      child: Text(
        '연간 분석 준비 중...',
        style: AppTextStyles.caption,
      ),
    );
  }

  Widget _buildSummaryCard() {
    return CommonCard(
      padding: const EdgeInsets.all(16),
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '주간 요약',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '2023년 5월 15일 - 21일',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('기록한 꿈', '9'),
              _buildSummaryItem('가장 많은 감정', '평화로움'),
              _buildSummaryItem('기억률', '68%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildEmotionDistribution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: '감정 분포',
        ),
        CommonCard(
          child: Column(
            children: _emotionCounts.entries.map((entry) {
              final percentage = (entry.value /
                      _emotionCounts.values.reduce((a, b) => a + b) *
                      100)
                  .toInt();
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildProgressBar(
                    entry.key, percentage, _getEmotionColor(entry.key)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDreamThemes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: '꿈 테마',
        ),
        CommonCard(
          child: Column(
            children: _dreamThemes.entries.map((entry) {
              final percentage = (entry.value /
                      _dreamThemes.values.reduce((a, b) => a + b) *
                      100)
                  .toInt();
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildProgressBar(
                    entry.key, percentage, Theme.of(context).primaryColor),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(String label, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.bodyEmphasis(context)),
            Text('$percentage%', style: AppTextStyles.caption),
          ],
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              height: 10,
              width:
                  MediaQuery.of(context).size.width * (percentage / 100) * 0.8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeeklyPattern() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: '요일별 꿈 기록',
        ),
        CommonCard(
          child: Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    final height = _weeklyDreamCounts[index] * 30.0;
                    return _buildDayBar(
                      _getDayName(index),
                      height > 0 ? height : 10,
                      _weeklyDreamCounts[index],
                      Theme.of(context)
                          .primaryColor
                          .withOpacity(height > 0 ? 1.0 : 0.3),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayBar(String day, double height, int count, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          count.toString(),
          style: AppTextStyles.caption,
        ),
        const SizedBox(height: 4),
        Container(
          width: 30,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: '꿈 인사이트',
        ),
        Column(
          children: _insights.map((insight) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CommonCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: insight['color'].withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        insight['icon'] as IconData,
                        color: insight['color'] as Color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insight['title'] as String,
                            style: AppTextStyles.heading3(context),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            insight['description'] as String,
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getDayName(int index) {
    const days = ['월', '화', '수', '목', '금', '토', '일'];
    return days[index];
  }

  Color _getEmotionColor(String emotion) {
    switch (emotion) {
      case '평화로움':
        return Colors.blue;
      case '불안함':
        return Colors.orange;
      case '기쁨':
        return Colors.green;
      case '혼란스러움':
        return Colors.purple;
      case '공포':
        return Colors.red;
      default:
        return Theme.of(context).primaryColor;
    }
  }
}
