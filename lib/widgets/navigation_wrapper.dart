import 'package:flutter/material.dart';

import 'dev_navigation.dart';

class NavigationWrapper extends StatefulWidget {
  final Widget child;

  const NavigationWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
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
            child: const DevNavigation(),
          ),
      ],
    );
  }
}
