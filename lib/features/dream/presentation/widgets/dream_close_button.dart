import 'package:dream_catcher/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DreamCloseButton extends StatelessWidget {
  const DreamCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        onPressed: () {
          try {
            context.pop();
          } catch (e) {
            context.go(AppRoutePath.home);
          }
        },
      ),
    );
  }
}
