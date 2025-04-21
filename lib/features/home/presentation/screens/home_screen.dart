import 'package:dream_catcher/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      body: const SafeArea(
        child: Column(
          children: [
            HomeAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    GreetingWidget(),
                    SizedBox(height: 24),
                    DreamSummaryWidget(),
                    SizedBox(height: 24),
                    RecentDreamsWidget(),
                    SizedBox(height: 24),
                    DreamStatsWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          context.push(AppRoutePath.dreamInterview);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
