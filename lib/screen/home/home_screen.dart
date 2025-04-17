import 'package:dream_catcher/routes.dart';
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
        backgroundColor: const Color(0xFF6666CC),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.dreamInterview);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Dream Catcher',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D4D99),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF6666CC)),
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
        const Text(
          '안녕하세요, 사용자님',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF8080B2),
          ),
        ),
      ],
    );
  }

  Widget _buildDreamSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF6666CC),
        borderRadius: BorderRadius.circular(16),
      ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '최근 꿈',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D4D99),
              ),
            ),
            TextButton(
              onPressed: () {
                // 모든 꿈 목록 화면으로 이동
              },
              child: const Text(
                '모두 보기',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6666CC),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildDreamItem(
          title: '바다에서 수영하는 꿈',
          date: '2023년 5월 15일',
          mood: '평화로움',
          color: const Color(0xFF6699CC),
        ),
        const SizedBox(height: 12),
        _buildDreamItem(
          title: '하늘을 나는 꿈',
          date: '2023년 5월 12일',
          mood: '신남',
          color: const Color(0xFF66CCCC),
        ),
      ],
    );
  }

  Widget _buildDreamItem({
    required String title,
    required String date,
    required String mood,
    required Color color,
  }) {
    return Container(
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
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4D4D99),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date · $mood',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8080B2),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Color(0xFF8080B2),
          ),
        ],
      ),
    );
  }

  Widget _buildDreamStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '꿈 통계',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
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
            children: [
              _buildStatItem('가장 많은 감정', '평화로움', const Color(0xFF66CCCC)),
              const SizedBox(height: 16),
              _buildStatItem('가장 많은 장소', '바다', const Color(0xFF6699CC)),
              const SizedBox(height: 16),
              _buildStatItem('가장 자주 등장하는 인물', '친구', const Color(0xFFCC6699)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8080B2),
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4D4D99),
          ),
        ),
      ],
    );
  }
}
