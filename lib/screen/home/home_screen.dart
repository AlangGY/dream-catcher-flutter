import 'package:dream_catcher/routes.dart';
import 'package:dream_catcher/ui/ui_export.dart';
import 'package:dream_catcher/widgets/common_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool showBottomNav = true;
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildGreeting(),
                    const SizedBox(height: 24),
                    _buildDreamSummary(),
                    const SizedBox(height: 24),
                    _buildRecentDreams(),
                    const SizedBox(height: 24),
                    _buildDreamStats(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.dreamInterview);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAppBar() {
    return CommonCard(
      width: double.infinity,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dream Catcher',
            style: AppTextStyles.heading2(context),
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined,
                color: Theme.of(context).primaryColor),
            onPressed: () {
              // 알림 기능
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '안녕하세요, 사용자님',
          style: AppTextStyles.heading1(context),
        ),
        const SizedBox(height: 8),
        Text(
          '${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildDreamSummary() {
    return CommonCard(
      padding: const EdgeInsets.all(20),
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.nightlight_round, color: Colors.white),
              SizedBox(width: 8),
              Text(
                '꿈 요약',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSummaryItem('기록한 꿈', '24'),
              _buildSummaryItem('이번 주', '3'),
              _buildSummaryItem('악몽', '5'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
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
      ),
    );
  }

  Widget _buildRecentDreams() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWithMore(
          title: '최근 꿈',
          onMoreTap: () {
            Navigator.pushNamed(context, AppRoutes.dreamList);
          },
        ),
        const SizedBox(height: 12),
        _buildDreamCard(
          '바다에서 수영하는 꿈',
          '2023년 5월 15일',
          '평화로움',
          const Color(0xFF6699CC),
        ),
        const SizedBox(height: 12),
        _buildDreamCard(
          '하늘을 나는 꿈',
          '2023년 5월 12일',
          '신남',
          const Color(0xFF66CCCC),
        ),
      ],
    );
  }

  Widget _buildDreamCard(String title, String date, String mood, Color color) {
    return CommonCard(
      child: Row(
        children: [
          Container(
            width: 6,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading3(context),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(date, style: AppTextStyles.captionSmall),
                    const SizedBox(width: 16),
                    Icon(Icons.emoji_emotions_outlined, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(mood, style: AppTextStyles.captionSmall),
                  ],
                ),
                const SizedBox(height: 12),
                TagsWrap(
                  tags: ['바다', '수영'],
                  tagColor: color,
                  showHashtag: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDreamStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: '나의 꿈 통계',
        ),
        CommonCard(
          child: Column(
            children: [
              _buildStatRow('가장 많이 꾸는 꿈', '바다에서의 경험 (32%)'),
              const Divider(),
              _buildStatRow('가장 많은 감정', '평화로움 (45%)'),
              const Divider(),
              _buildStatRow('이번 달 기록', '12회'),
              const Divider(),
              _buildStatRow('평균 선명도', '3.2 / 5'),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.dreamAnalysis);
                  },
                  child: Text(
                    '자세한 분석 보기',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.caption),
          Text(
            value,
            style: AppTextStyles.bodyEmphasis(context),
          ),
        ],
      ),
    );
  }
}
