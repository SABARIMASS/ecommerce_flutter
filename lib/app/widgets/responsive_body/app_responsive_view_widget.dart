import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileScreen,
    required this.tabletScreen,
    required this.desktopScreen,
  });
  final Widget mobileScreen, tabletScreen, desktopScreen;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileScreen;
        } else if (constraints.minWidth < 1100) {
          return tabletScreen;
        } else {
          return desktopScreen;
        }
      },
    );
  }
}
