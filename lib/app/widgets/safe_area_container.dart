import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SafeAreaContainer extends StatelessWidget {
  final Widget child;
  final bool isTabBarShown;
  final Color? statusBarColor;
  final Color? systemNavigationBarColor;

  const SafeAreaContainer({
    super.key,
    required this.child,
    this.isTabBarShown = false,
    this.statusBarColor,
    this.systemNavigationBarColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultStatusBarColor = statusBarColor ?? Colors.white;
    final Color defaultNavigationBarColor =
        systemNavigationBarColor ?? Colors.white;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: defaultStatusBarColor,
        statusBarBrightness: Brightness.light, // iOS control
        statusBarIconBrightness: Brightness.dark, // Android control
        systemNavigationBarColor: defaultNavigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: child,
    );
  }
}
