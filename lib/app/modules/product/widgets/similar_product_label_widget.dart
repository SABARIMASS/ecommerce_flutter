import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/app_style.dart';

class SimilarProductLabelWidget extends StatelessWidget {
  const SimilarProductLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                        fontWeight: AppFontWeight.semiBold.value,
                        fontSize: AppFontSize.extraSmall.value,
                        color: AppColors.kPrimaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: AppColors.kGreyColor.withValues(alpha: 0.3)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: 20.h,
                child: Text(
                  "Rating",
                  style: TextStyle(
                    fontWeight: AppFontWeight.semiBold.value,
                    fontSize: AppFontSize.extraSmall.value,
                    color: AppColors.kPrimaryTextColor,
                  ),
                ),
              ),
            ),
            Divider(color: AppColors.kGreyColor.withValues(alpha: 0.3)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "Ingredient\nHighlights",
                  style: TextStyle(
                    fontWeight: AppFontWeight.semiBold.value,
                    fontSize: AppFontSize.extraSmall.value,
                    color: AppColors.kPrimaryTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
