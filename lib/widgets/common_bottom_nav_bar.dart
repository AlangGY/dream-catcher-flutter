import 'package:dream_catcher/routes.dart';
import 'package:flutter/material.dart';

class CommonBottomNavBar extends StatelessWidget {
  const CommonBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 현재 경로 가져오기
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    // 현재 경로에 따라 인덱스 결정
    int currentIndex = _getIndexFromRoute(currentRoute);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF6666CC),
        unselectedItemColor: const Color(0xFF8080B2),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: '기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined),
            activeIcon: Icon(Icons.auto_graph),
            label: '분석',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
        onTap: (index) => _onItemTapped(context, index, currentRoute),
      ),
    );
  }

  // 탭 클릭 시 처리하는 함수
  void _onItemTapped(BuildContext context, int index, String currentRoute) {
    String targetRoute;

    switch (index) {
      case 0:
        targetRoute = AppRoutes.home;
        break;
      case 1:
        targetRoute = AppRoutes.dreamList;
        break;
      case 2:
        targetRoute = AppRoutes.dreamAnalysis;
        break;
      case 3:
        targetRoute = AppRoutes.profile;
        break;
      default:
        targetRoute = AppRoutes.home;
    }

    // 현재 경로와 같으면 중복 이동하지 않음
    if (_getIndexFromRoute(currentRoute) == index) return;

    Navigator.pushNamed(context, targetRoute);
  }

  // 경로에 따라 인덱스 결정하는 함수
  int _getIndexFromRoute(String route) {
    if (route == AppRoutes.home) {
      return 0;
    } else if (route == AppRoutes.dreamList ||
        route == AppRoutes.dreamDetail ||
        route == AppRoutes.dreamInterview ||
        route == AppRoutes.dreamAlarm ||
        route == AppRoutes.dreamRealtimeChat) {
      return 1;
    } else if (route == AppRoutes.dreamAnalysis) {
      return 2;
    } else if (route == AppRoutes.profile) {
      return 3;
    }
    return 0; // 기본값은 홈
  }
}
