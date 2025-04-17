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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '꿈 분석',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF6666CC),
          unselectedLabelColor: const Color(0xFF8080B2),
          indicatorColor: const Color(0xFF6666CC),
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
        style: TextStyle(
          fontSize: 18,
          color: Color(0xFF8080B2),
        ),
      ),
    );
  }

  Widget _buildYearlyAnalysis() {
    // 연간 분석 화면 (주간과 유사하지만 데이터만 다름)
    return Center(
      child: Text(
        '연간 분석 준비 중...',
        style: TextStyle(
          fontSize: 18,
          color: Color(0xFF8080B2),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6666CC),
        borderRadius: BorderRadius.circular(16),
      ),
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
            fontSize: 22,
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
    return _buildSectionCard(
      title: '감정별 꿈 분포',
      child: Column(
        children: _emotionCounts.entries.map((entry) {
          final percent = (entry.value /
                  _emotionCounts.values
                      .fold<double>(0, (a, b) => a + b.toDouble()) *
                  100)
              .toInt();
          final color = _getEmotionColor(entry.key);

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${entry.key} (${entry.value})',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4D4D99),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$percent%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4D4D99),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: entry.value.toDouble() /
                      _emotionCounts.values
                          .fold<double>(0, (a, b) => a + b.toDouble()),
                  backgroundColor: const Color(0xFFE1E1F9),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  borderRadius: BorderRadius.circular(2),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDreamThemes() {
    return _buildSectionCard(
      title: '꿈 주제 분석',
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 180,
              child: CustomPaint(
                painter: PieChartPainter(_dreamThemes),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _dreamThemes.entries.map((entry) {
                final color = _getThemeColor(entry.key);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${entry.key} (${entry.value})',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4D4D99),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyPattern() {
    final daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];

    return _buildSectionCard(
      title: '주간 기록 패턴',
      child: SizedBox(
        height: 160,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(7, (index) {
            final count = _weeklyDreamCounts[index];
            final maxCount = _weeklyDreamCounts.reduce((a, b) => a > b ? a : b);
            final height = count > 0 ? 100 * (count / maxCount) : 10;

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 30,
                  height: height.toDouble(),
                  decoration: BoxDecoration(
                    color: count > 0
                        ? const Color(0xFF6666CC)
                        : const Color(0xFFE1E1F9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      color: count > 0 ? Colors.white : const Color(0xFF8080B2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  daysOfWeek[index],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8080B2),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            'AI 인사이트',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D4D99),
            ),
          ),
        ),
        ..._insights.map((insight) => _buildInsightCard(insight)),
      ],
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> insight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (insight['color'] as Color).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              insight['icon'] as IconData,
              color: insight['color'] as Color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D4D99),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  insight['description'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D4D99),
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Color _getEmotionColor(String emotion) {
    switch (emotion) {
      case '평화로움':
        return const Color(0xFF66CCCC);
      case '불안함':
        return const Color(0xFFCC6666);
      case '기쁨':
        return const Color(0xFF66CC99);
      case '혼란스러움':
        return const Color(0xFFCC9966);
      case '공포':
        return const Color(0xFF9966CC);
      default:
        return const Color(0xFF8080B2);
    }
  }

  Color _getThemeColor(String theme) {
    switch (theme) {
      case '물/바다':
        return const Color(0xFF6699CC);
      case '비행':
        return const Color(0xFF66CCCC);
      case '추격':
        return const Color(0xFFCC6666);
      case '시험':
        return const Color(0xFFCC9966);
      case '사랑하는 사람':
        return const Color(0xFFCC66CC);
      default:
        return const Color(0xFF8080B2);
    }
  }
}

// 파이 차트를 그리기 위한 커스텀 페인터
class PieChartPainter extends CustomPainter {
  final Map<String, int> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;

    final total = data.values.reduce((a, b) => a + b);
    var startAngle = -1.5708; // -90도, 12시 방향에서 시작

    data.forEach((key, value) {
      final sweepAngle = value / total * 6.2832; // 2 * pi
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = _getThemeColor(key);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    });

    // 중앙에 흰색 원 그리기 (도넛 모양으로 만들기)
    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    canvas.drawCircle(center, radius * 0.6, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Color _getThemeColor(String theme) {
    switch (theme) {
      case '물/바다':
        return const Color(0xFF6699CC);
      case '비행':
        return const Color(0xFF66CCCC);
      case '추격':
        return const Color(0xFFCC6666);
      case '시험':
        return const Color(0xFFCC9966);
      case '사랑하는 사람':
        return const Color(0xFFCC66CC);
      default:
        return const Color(0xFF8080B2);
    }
  }
}
