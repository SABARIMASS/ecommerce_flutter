import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/shared/app_style.dart';
import '../loader_widgets/app_loader.dart';
import 'custom_icon_button.dart';

class PaginationLoader extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final bool? showMessage;

  const PaginationLoader({
    super.key,
    required this.isLoading,
    this.errorMessage,
    this.onRetry,
    this.showMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Center(child: AppLoader()),
      );
    } else if (errorMessage != null &&
        errorMessage!.isNotEmpty &&
        showMessage == true) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: CustomIconButton(
          radius: 8.r,
          iconColor: AppColors.kIconPrimaryColor.withValues(alpha: 0.5),
          onTap: onRetry,
          icon: Icons.refresh,
        ),
      );
    }
    return const SizedBox.shrink(); // No loading or error state
  }
}
