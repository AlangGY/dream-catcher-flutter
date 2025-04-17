import 'package:dream_catcher/ui/ui_export.dart';
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
      appBar: CommonAppBar(
        title: '프로필',
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined,
                color: Theme.of(context).primaryColor),
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
    return CommonCard(
      padding: const EdgeInsets.all(24),
      margin: EdgeInsets.zero,
      width: double.infinity,
      borderRadius: 0,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE1E1F9),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _userData['name'],
            style: AppTextStyles.heading1(context),
          ),
          const SizedBox(height: 4),
          Text(
            _userData['email'],
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 8),
          Text(
            '가입일: ${_userData['joinDate']}',
            style: AppTextStyles.captionSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return CommonCard(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: '나의 통계',
            padding: const EdgeInsets.only(bottom: 16),
          ),
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
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.heading3(context),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.captionSmall,
          ),
        ],
      ],
    );
  }

  Widget _buildSettingsSection() {
    return CommonCard(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '설정',
              style: AppTextStyles.heading2(context),
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
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor.withOpacity(0.8),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildSettingsTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor.withOpacity(0.8),
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
