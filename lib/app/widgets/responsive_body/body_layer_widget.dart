import 'package:flutter/material.dart';
import '../../../shared/app_style.dart';
import '../loader_widgets/app_loader.dart';

class BodyOverLayWidget extends StatelessWidget {
  final bool isLoader;
  final Widget child;
  final Widget? loadingWidget;

  const BodyOverLayWidget({
    super.key,
    required this.isLoader,
    required this.child,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          child, // The child widget will always be shown
          if (isLoader) ...[
            // Background shadow when loader is active
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
            // Loader in the center
            Center(
              child: loadingWidget ?? AppLoader(color: AppColors.kPrimaryColor),
            ),
          ],
        ],
      ),
    );
  }
}
