import 'package:dream_catcher/shared/widgets/app_logo.dart';
import 'package:dream_catcher/shared/widgets/kakao_login_button.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              const AppLogo(),
              const Spacer(flex: 1),
              KakaoLoginButton(
                onPressed: () {
                  // TODO: 카카오 로그인 로직 구현
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// 기능 설명 아이템을 위한 위젯
class FeatureItem extends StatelessWidget {
  final Widget icon;
  final String text;

  const FeatureItem({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
