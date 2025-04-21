import 'package:dream_catcher/devtools/widgets/dev_navigation_wrapper.dart';
import 'package:dream_catcher/features/analysis/presentation/screens/dream_analysis_screen.dart';
import 'package:dream_catcher/features/auth/presentation/screens/register_screen.dart';
import 'package:dream_catcher/features/dream/presentation/screens/dream_alarm_screen.dart';
import 'package:dream_catcher/features/dream/presentation/screens/dream_detail_screen.dart';
import 'package:dream_catcher/features/dream/presentation/screens/dream_interview_screen.dart';
import 'package:dream_catcher/features/dream/presentation/screens/dream_list_screen.dart';
import 'package:dream_catcher/features/dream/presentation/screens/dream_realtime_chat_screen.dart';
import 'package:dream_catcher/features/home/presentation/screens/home_screen.dart';
import 'package:dream_catcher/features/landing/presentation/screens/landing_screen.dart';
import 'package:dream_catcher/features/profile/presentation/screens/profile_screen.dart';
import 'package:dream_catcher/shared/widgets/common_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> devNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutePath {
  static const String landing = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String dreamList = '/dream_list';
  static const String dreamDetail = '/dream_detail';
  static const String dreamInterview = '/dream_interview';
  static const String dreamAlarm = '/dream_alarm';
  static const String dreamRealtimeChat = '/dream_realtime_chat';
  static const String dreamAnalysis = '/dream_analysis';
  static const String profile = '/profile';
}

class AppRouteName {
  static const String landing = 'landing';
  static const String register = 'register';
  static const String home = 'home';
  static const String dreamList = 'dreamList';
  static const String dreamDetail = 'dreamDetail';
  static const String dreamInterview = 'dreamInterview';
  static const String dreamAlarm = 'dreamAlarm';
  static const String dreamRealtimeChat = 'dreamRealtimeChat';
  static const String dreamAnalysis = 'dreamAnalysis';
  static const String profile = 'profile';
}

final routes = [
  ShellRoute(
    navigatorKey: devNavigatorKey,
    builder: (context, state, child) {
      return DevNavigationWrapper(
          key: const Key('devNavigationWrapper'), child: child);
    },
    routes: [
      GoRoute(
        path: AppRoutePath.landing,
        name: AppRouteName.landing,
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: AppRoutePath.register,
        name: AppRouteName.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          final String currentPath =
              GoRouter.of(context).routeInformationProvider.value.uri.path;
          return Scaffold(
            body: child,
            bottomNavigationBar: CommonBottomNavBar(currentPath: currentPath),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutePath.home,
            name: AppRouteName.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutePath.dreamList,
            name: AppRouteName.dreamList,
            builder: (context, state) => const DreamListScreen(),
          ),
          GoRoute(
            path: AppRoutePath.profile,
            name: AppRouteName.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: AppRoutePath.dreamAlarm,
            name: AppRouteName.dreamAlarm,
            builder: (context, state) => const DreamAlarmScreen(),
          ),
          GoRoute(
            path: AppRoutePath.dreamAnalysis,
            name: AppRouteName.dreamAnalysis,
            builder: (context, state) => const DreamAnalysisScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePath.dreamDetail,
        name: AppRouteName.dreamDetail,
        builder: (context, state) => const DreamDetailScreen(),
      ),
      GoRoute(
        path: AppRoutePath.dreamInterview,
        name: AppRouteName.dreamInterview,
        builder: (context, state) => const DreamInterviewScreen(),
      ),
      GoRoute(
        path: AppRoutePath.dreamRealtimeChat,
        name: AppRouteName.dreamRealtimeChat,
        builder: (context, state) => const DreamRealtimeChatScreen(),
      ),
    ],
  ),
];

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutePath.landing,
  routes: routes,
);
