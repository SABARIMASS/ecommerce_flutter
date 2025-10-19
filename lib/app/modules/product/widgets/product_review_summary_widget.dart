import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../shared/app_style.dart';
import 'start_rating_widget.dart';

class ProductReviewSummary extends StatelessWidget {
  final double rating;
  final String reviewCount;
  final String favoriteCount;
  final List<String> ratedAttributes;

  const ProductReviewSummary({
    super.key,
    required this.rating,
    required this.reviewCount,
    required this.favoriteCount,
    required this.ratedAttributes,
  });

  @override
  Widget build(BuildContext context) {
    // Join the attributes with ' , ' for display.
    final attributesString = ratedAttributes.join(' , ');

    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.kGreyColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                // 1. Star Rating
                StarRating(rating: rating),

                Text(
                  reviewCount,
                  style: TextStyle(
                    color: AppColors.kPrimaryTextColor,
                    fontSize: AppFontSize.extraSmall.value,
                    fontWeight: AppFontWeight.bold.value,
                  ),
                ),
                SizedBox(width: 4.w),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  height: 10.h,
                  width: 1.w,
                  color: AppColors.kGreyColor.withValues(alpha: 0.1),
                ),

                Text(
                  'Ask a question',
                  style: TextStyle(
                    color: AppColors.kPrimaryTextColor,
                    fontSize: AppFontSize.extraSmall.value,
                    fontWeight: AppFontWeight.semiBold.value,
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  height: 10.h,
                  width: 1.w,
                  color: AppColors.kGreyColor.withValues(alpha: 0.1),
                ),

                HugeIcon(
                  icon: HugeIcons.strokeRoundedFavourite,
                  size: 16.w,
                  color: AppColors.kPrimaryTextColor,
                ),
                SizedBox(width: 4.w),

                Text(
                  favoriteCount,
                  style: TextStyle(
                    color: AppColors.kPrimaryTextColor,
                    fontSize: AppFontSize.extraSmall.value,
                    fontWeight: AppFontWeight.semiBold.value,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),

          RichText(
            text: TextSpan(
              style: TextStyle(
                color: AppColors.kPrimaryTextColor,
                fontSize: AppFontSize.extraSmall.value,
                fontWeight: AppFontWeight.semiBold.value,
              ),
              children: [
                const TextSpan(text: 'Highly rated by customers for : '),
                TextSpan(
                  text: attributesString,
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
