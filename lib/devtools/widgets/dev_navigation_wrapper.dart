import 'package:dream_catcher/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DevNavigationWrapper extends StatefulWidget {
  final Widget child;

  const DevNavigationWrapper({
    super.key,
    required this.child,
  });

  @override
  State<DevNavigationWrapper> createState() => _DevNavigationWrapperState();
}

class _DevNavigationWrapperState extends State<DevNavigationWrapper> {
  bool _showNav = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          right: 16,
          top: 40,
          child: FloatingActionButton(
            heroTag: 'devNavFAB',
            mini: true,
            backgroundColor: const Color(0xFF6666CC),
            onPressed: () {
              setState(() {
                _showNav = !_showNav;
              });
            },
            child: Icon(
              _showNav ? Icons.close : Icons.developer_mode,
              color: Colors.white,
            ),
          ),
        ),
        if (_showNav)
          const Positioned(
            right: 16,
            top: 100,
            child: DevNavigation(),
          ),
      ],
    );
  }
}

class DevNavigation extends StatelessWidget {
  final BuildContext? navigatorContext;

  const DevNavigation({
    super.key,
    this.navigatorContext,
  });

  String _getScreenName(String routeName) {
    switch (routeName) {
      case AppRouteName.landing:
        return '랜딩 화면';
      case AppRouteName.register:
        return '회원가입';
      case AppRouteName.home:
        return '홈';
      case AppRouteName.dreamList:
        return '꿈 목록';
      case AppRouteName.dreamDetail:
        return '꿈 상세';
      case AppRouteName.dreamInterview:
        return '꿈 인터뷰';
      case AppRouteName.dreamRealtimeChat:
        return '꿈 실시간 채팅';
      case AppRouteName.dreamAlarm:
        return '꿈 알람 설정';
      case AppRouteName.dreamAnalysis:
        return '꿈 분석';
      case AppRouteName.profile:
        return '프로필';
      default:
        return routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final flattenedRoutes = routes.expand((route) {
      // ignore: unnecessary_type_check
      if (route is ShellRoute) {
        return route.routes.expand((subRoute) {
          if (subRoute is ShellRoute) {
            return subRoute.routes;
          }
          return [subRoute];
        });
      }
      return [route];
    }).toList();

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
          ...flattenedRoutes.whereType<GoRoute>().map((route) {
            final name = _getScreenName(route.name ?? route.path);
            return _buildNavItem(
                context, name, route.path, route.name ?? route.path);
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, String name, String route, String routeName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            context.go(route);
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
}
