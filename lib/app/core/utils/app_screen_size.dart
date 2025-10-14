import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppResponsiveScreenSize {
  static Size screenSize(BuildContext context) {
    if (kIsWeb) {
      return const Size(1024, 768);
    } else {
      final TargetPlatform platform = defaultTargetPlatform;
      if (platform == TargetPlatform.android ||
          platform == TargetPlatform.iOS) {
        if (MediaQuery.of(context).size.shortestSide > 600) {
          return const Size(600, 1024); // Tablet
        } else {
          return const Size(360, 640); // Mobile
        }
      } else {
        return const Size(1280, 720); // Desktop
      }
    }
  }
}
