import 'package:dream_catcher/screen/analysis/dream_analysis_screen.dart';
import 'package:dream_catcher/screen/auth/register_screen.dart';
import 'package:dream_catcher/screen/dream/dream_alarm_screen.dart';
import 'package:dream_catcher/screen/dream/dream_detail_screen.dart';
import 'package:dream_catcher/screen/dream/dream_interview_screen.dart';
import 'package:dream_catcher/screen/dream/dream_list_screen.dart';
import 'package:dream_catcher/screen/dream/dream_realtime_chat_screen.dart';
import 'package:dream_catcher/screen/home/home_screen.dart';
import 'package:dream_catcher/screen/landing/landing_screen.dart';
import 'package:dream_catcher/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';

// 앱의 모든 라우트를 정의하는 클래스
class AppRoutes {
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

  // 추후 추가될 화면들의 라우트 경로를 여기에 정의

  // 앱의 라우트 맵을 생성하는 메서드
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      landing: (context) => const LandingScreen(),
      register: (context) => const RegisterScreen(),
      home: (context) => const HomeScreen(),
      dreamList: (context) => const DreamListScreen(),
      dreamDetail: (context) => const DreamDetailScreen(),
      dreamInterview: (context) => const DreamInterviewScreen(),
      dreamAlarm: (context) => const DreamAlarmScreen(),
      dreamRealtimeChat: (context) => const DreamRealtimeChatScreen(),
      dreamAnalysis: (context) => const DreamAnalysisScreen(),
      profile: (context) => const ProfileScreen(),
      // 추후 추가될 화면들의 라우트를 여기에 등록
    };
  }
}
