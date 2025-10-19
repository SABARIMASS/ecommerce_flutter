import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/app/core/helpers/app_info.dart';
import 'package:sephora/app/modules/product/data/product_detail_api_data.dart';
import '../../../../shared/app_style.dart';
import '../../../core/utils/percentage.dart';

import 'package:flutter_html/flutter_html.dart';

import 'image_slider_widget.dart';

class CustomProductDetailWidget extends StatelessWidget {
  final ProductData product;

  const CustomProductDetailWidget({super.key, required this.product});

  Widget _buildTopInfoSection() {
    Widget starRatingRow() {
      if (product.averageRating == null) return const SizedBox.shrink();
      int fullStars = product.averageRating!.floor();
      bool hasHalfStar = (product.averageRating! - fullStars) >= 0.5;
      int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

      List<Widget> stars = [];
      for (int i = 0; i < fullStars; i++) {
        stars.add(Icon(Icons.star, color: Colors.yellow, size: 14.sp));
        stars.add(SizedBox(width: 1.w));
      }
      if (hasHalfStar) {
        stars.add(Icon(Icons.star_half, color: Colors.yellow, size: 14.sp));
        stars.add(SizedBox(width: 1.w));
      }
      for (int i = 0; i < emptyStars; i++) {
        stars.add(
          Icon(
            Icons.star_border,
            color: AppColors.kPrimaryTextColor,
            size: 14.sp,
          ),
        );
        if (i != emptyStars - 1) stars.add(SizedBox(width: 1.w));
      }

      return Row(mainAxisSize: MainAxisSize.min, children: stars);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Collection & Product Name
          if (product.title != null)
            Text(
              product.title!,
              style: TextStyle(
                fontWeight: AppFontWeight.bold.value,
                fontSize: AppFontSize.large.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          SizedBox(height: 6.h),

          // Rating and Review
          Row(
            children: [
              if (product.averageRating != null) starRatingRow(),
              SizedBox(width: 4.w),
              if (product.averageRating != null)
                Text(
                  "${product.averageRating!.toString()} / 5",
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    fontSize: AppFontSize.small.value,
                    color: AppColors.kPrimaryTextColor,
                  ),
                ),
              SizedBox(width: 10.w),

              const Spacer(),

              Text(
                '${product.reviewsCount} reviews', // Hardcoded from image
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.small.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Auto-Replenish Save Text
          if ((product.variants?.firstOrNull?.specialPrice ?? 0) > 0 &&
              (product.variants?.firstOrNull?.specialPrice ?? 0) <
                  (product.variants?.firstOrNull?.price ?? 0))
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  // Original Price (Strikethrough)
                  Text(
                    '${AppInfo.kCurrency}${product.variants?.firstOrNull?.price?.toStringAsFixed(2)}',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: AppFontWeight.medium.value,
                      fontSize: AppFontSize.small.value,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 6.w),

                  // Discounted Price (Bold)
                  Text(
                    '${AppInfo.kCurrency}${product.variants?.firstOrNull?.specialPrice?.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: AppFontWeight.bold.value,
                      fontSize: AppFontSize.small.value,
                      color: AppColors.kPrimaryTextColor,
                    ),
                  ),
                  SizedBox(width: 6.w),

                  // Offer Percentage (Colored)
                  Text(
                    '(${ProductHelpers.calculateOfferPercentage(product.variants?.firstOrNull?.price?.toDouble() ?? 0, product.variants?.firstOrNull?.specialPrice?.toDouble() ?? 0).toStringAsFixed(0)}% OFF)',
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontWeight: AppFontWeight.bold.value,
                      fontSize: AppFontSize.small.value,
                    ),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text(
                '${AppInfo.kCurrency}${product.variants?.firstOrNull?.price?.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: AppFontWeight.bold.value,
                  fontSize: AppFontSize.small.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper: About the Product Section
  Widget _buildAboutProductSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1,
            color: AppColors.kHintTextColor.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            'About the Product',
            style: TextStyle(
              fontWeight: AppFontWeight.bold.value,
              fontSize: AppFontSize.large.value,
              color: AppColors.kPrimaryTextColor,
            ),
          ),

          if (product.description != null &&
              product.description!.trim().isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Html(
                data: product.description!,

                // optional: limit default margins/padding so it fits your style
              ),
            )
          else
            SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageCarousel(productImages: product.productImages ?? []),

          _buildTopInfoSection(),

          _buildAboutProductSection(),
        ],
      ),
    );
  }

  // Widget _buildOptionRow(IconData icon, String title, String? subtitle) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 8.h),
  //     child: Row(
  //       children: [
  //         Icon(icon, color: AppColors.kPrimaryTextColor, size: 24.sp),
  //         SizedBox(width: 12.w),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontWeight: AppFontWeight.medium.value,
  //                 fontSize: AppFontSize.medium.value,
  //                 color: AppColors.kPrimaryTextColor,
  //               ),
  //             ),
  //             if (subtitle != null)
  //               Text(
  //                 subtitle,
  //                 style: TextStyle(
  //                   fontWeight: AppFontWeight.medium.value,
  //                   fontSize: AppFontSize.small.value,
  //                   color: AppColors.kPrimaryColor,
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
