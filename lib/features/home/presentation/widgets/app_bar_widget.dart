import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      width: double.infinity,
      margin: EdgeInsets.zero,
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dream Catcher',
            style: AppTextStyles.heading2(context),
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined,
                color: Theme.of(context).primaryColor),
            onPressed: () {
              // 알림 기능
            },
          ),
        ],
      ),
    );
  }
}
