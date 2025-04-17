import 'package:dream_catcher/widgets/common_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final bool showBottomNav = true;
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 사용자 데이터 (실제로는 상태 관리 솔루션이나 API에서 가져올 것)
  final Map<String, dynamic> _userData = {
    'name': '김꿈나무',
    'email': 'dream@example.com',
    'joinDate': '2023년 3월 15일',
    'totalDreams': 42,
    'streakDays': 12,
  };

  // 설정 항목
  final List<Map<String, dynamic>> _settingsItems = [
    {
      'icon': Icons.notifications_outlined,
      'title': '알림 설정',
      'route': '/notifications',
    },
    {
      'icon': Icons.color_lens_outlined,
      'title': '테마 설정',
      'route': '/theme',
    },
    {
      'icon': Icons.lock_outline,
      'title': '개인정보 관리',
      'route': '/privacy',
    },
    {
      'icon': Icons.help_outline,
      'title': '도움말',
      'route': '/help',
    },
    {
      'icon': Icons.info_outline,
      'title': '앱 정보',
      'route': '/about',
    },
  ];

  bool _isDarkMode = false;
  bool _isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '프로필',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF6666CC)),
            onPressed: () {
              // 프로필 편집 화면으로 이동
              // Navigator.pushNamed(context, '/edit_profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 16),
            _buildStatsCard(),
            const SizedBox(height: 16),
            _buildSettingsSection(),
            const SizedBox(height: 16),
            _buildLogoutButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE1E1F9),
              border: Border.all(
                color: const Color(0xFF6666CC),
                width: 3,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _userData['name'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D4D99),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _userData['email'],
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF8080B2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '가입일: ${_userData['joinDate']}',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8080B2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
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
          const Text(
            '나의 통계',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D4D99),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.auto_stories,
                _userData['totalDreams'].toString(),
                '기록한 꿈',
              ),
              _buildStatItem(
                Icons.local_fire_department,
                _userData['streakDays'].toString(),
                '연속 기록일',
              ),
              _buildStatItem(
                Icons.emoji_emotions,
                '68%',
                '평화로움',
                subtitle: '가장 많은 감정',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label,
      {String? subtitle}) {
    return Column(
      children: [
        Icon(
          icon,
          size: 28,
          color: const Color(0xFF6666CC),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF8080B2),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8080B2),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '설정',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D4D99),
              ),
            ),
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            '다크 모드',
            Icons.dark_mode_outlined,
            _isDarkMode,
            (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            '알림',
            Icons.notifications_outlined,
            _isNotificationEnabled,
            (value) {
              setState(() {
                _isNotificationEnabled = value;
              });
            },
          ),
          const Divider(height: 1),
          ..._settingsItems.map((item) => _buildSettingsTile(
                item['title'],
                item['icon'],
                () {
                  // 해당 설정 화면으로 이동
                  // Navigator.pushNamed(context, item['route']);
                },
              )),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
      String title, IconData icon, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF6666CC),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF4D4D99),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF6666CC),
      ),
    );
  }

  Widget _buildSettingsTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF6666CC),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF4D4D99),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(0xFF8080B2),
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          // 로그아웃 처리
          // showDialog로 로그아웃 확인
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFFCC6666),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFCC6666)),
          ),
        ),
        child: const Text(
          '로그아웃',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
