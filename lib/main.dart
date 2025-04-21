import 'package:dream_catcher/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'injection_container.dart' as di;

// 전역 navigator key 정의
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Dream Catcher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6666CC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6666CC),
          primary: const Color(0xFF6666CC),
        ),
        fontFamily: 'PretendardStd',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}
