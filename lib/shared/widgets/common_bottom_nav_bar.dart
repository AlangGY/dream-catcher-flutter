import 'package:dream_catcher/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonBottomNavBar extends StatelessWidget {
  final String currentPath;

  const CommonBottomNavBar({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    // 현재 경로에 따라 인덱스 결정
    int currentIndex = _getIndexFromRoutePath(currentPath);

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
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: '기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined),
            label: '분석',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
        onTap: (index) => _onItemTapped(context, index, currentPath),
      ),
    );
  }

  // 탭 클릭 시 처리하는 함수
  void _onItemTapped(BuildContext context, int index, String currentRoute) {
    String targetRoute;

    switch (index) {
      case 0:
        targetRoute = AppRoutePath.home;
        break;
      case 1:
        targetRoute = AppRoutePath.dreamList;
        break;
      case 2:
        targetRoute = AppRoutePath.dreamAnalysis;
        break;
      case 3:
        targetRoute = AppRoutePath.profile;
        break;
      default:
        targetRoute = AppRoutePath.home;
    }

    // 현재 경로와 같으면 중복 이동하지 않음
    context.go(targetRoute);
  }

  // 경로에 따라 인덱스 결정하는 함수
  int _getIndexFromRoutePath(String routePath) {
    if (routePath == AppRoutePath.home) {
      return 0;
    } else if (routePath == AppRoutePath.dreamList ||
        routePath == AppRoutePath.dreamDetail ||
        routePath == AppRoutePath.dreamInterview ||
        routePath == AppRoutePath.dreamAlarm ||
        routePath == AppRoutePath.dreamRealtimeChat) {
      return 1;
    } else if (routePath == AppRoutePath.dreamAnalysis) {
      return 2;
    } else if (routePath == AppRoutePath.profile) {
      return 3;
    }
    return 0; // 기본값은 홈
  }
}
