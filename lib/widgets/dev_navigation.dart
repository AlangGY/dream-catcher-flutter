import 'package:flutter/material.dart';

import '../main.dart'; // navigatorKey 임포트

class DevNavigation extends StatelessWidget {
  final BuildContext? navigatorContext;

  const DevNavigation({
    Key? key,
    this.navigatorContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 앱의 모든 스크린 경로와 이름
    final List<Map<String, String>> screens = [
      {'name': '랜딩 화면', 'route': '/'},
      {'name': '회원가입', 'route': '/register'},
      {'name': '홈', 'route': '/home'},
      {'name': '꿈 목록', 'route': '/dream_list'},
      {'name': '꿈 상세', 'route': '/dream_detail'},
      {'name': '꿈 인터뷰', 'route': '/dream_interview'},
      {'name': '꿈 실시간 채팅', 'route': '/dream_realtime_chat'},
      {'name': '꿈 알람 설정', 'route': '/dream_alarm'},
      {'name': '꿈 분석', 'route': '/dream_analysis'},
      {'name': '프로필', 'route': '/profile'},
      // 추가 스크린은 여기에 추가
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.developer_mode, color: Color(0xFF6666CC)),
              SizedBox(width: 8),
              Text(
                '개발 네비게이션',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF4D4D99),
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          ...screens.map((screen) =>
              _buildNavItem(context, screen['name']!, screen['route']!)),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String name, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            _navigateToRoute(route);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2FF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF6666CC),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFF6666CC),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToRoute(String route) {
    // 전역 navigatorKey를 사용하여 네비게이션
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed(route);
    }
  }
}
