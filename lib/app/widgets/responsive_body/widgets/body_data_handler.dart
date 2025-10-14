import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/app_style.dart';
import '../../loader_widgets/app_loader.dart';

class BodyDataHandler extends StatelessWidget {
  const BodyDataHandler({
    super.key,
    required this.body,
    required this.loader,
    required this.noBodyData,
    required this.errorMessage,
    required this.showBodyWidget,
    this.errorWidget,
    this.loaderWidget,
  });
  final Widget body;
  final bool loader;
  final bool noBodyData;
  final bool showBodyWidget;
  final String? errorMessage;
  final Widget? loaderWidget;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    if (loader) {
      return loaderWidget ?? const Center(child: AppLoader());
    } else if (noBodyData) {
      return errorWidget ??
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Text(
                errorMessage ?? "No Data Found.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.kPrimaryTextColor,
                  fontSize: AppFontSize.small.value,
                  fontWeight: AppFontWeight.semiBold.value,
                ),
              ),
            ),
          );
    } else if (!showBodyWidget) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Text(
            "Something Went Wrong .",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.kPrimaryTextColor,
              fontSize: AppFontSize.small.value,
              fontWeight: AppFontWeight.semiBold.value,
            ),
          ),
        ),
      );
    } else {
      return body;
    }
  }
}
