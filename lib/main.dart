import 'package:dream_catcher/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 전역 navigator key 정의
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
