import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/app_style.dart';
import '../../../core/utils/constants/image_assets.dart';
import '../data/product_info_api_data.dart';

class CustomProductDetailWidget extends StatelessWidget {
  final ProductInfoItem product;

  const CustomProductDetailWidget({super.key, required this.product});

  Widget _buildTopInfoSection() {
    final double planAmount = (product.actualPrice ?? 16.00) / 4;

    Widget starRatingRow() {
      if (product.rating == null) return const SizedBox.shrink();
      int fullStars = product.rating!.floor();
      bool hasHalfStar = (product.rating! - fullStars) >= 0.5;
      int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

      List<Widget> stars = [];
      for (int i = 0; i < fullStars; i++) {
        stars.add(
          Icon(Icons.star, color: AppColors.kPrimaryTextColor, size: 14.sp),
        );
        stars.add(SizedBox(width: 1.w));
      }
      if (hasHalfStar) {
        stars.add(
          Icon(
            Icons.star_half,
            color: AppColors.kPrimaryTextColor,
            size: 14.sp,
          ),
        );
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
          if (product.productName != null)
            Text(
              product.productName!,
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
              if (product.rating != null) starRatingRow(),
              SizedBox(width: 4.w),
              if (product.rating != null)
                Text(
                  product.rating!.toString(),
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    fontSize: AppFontSize.small.value,
                    color: AppColors.kPrimaryTextColor,
                  ),
                ),
              SizedBox(width: 10.w),
              Text(
                'Ask a question',
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.small.value,
                  color: AppColors.kPrimaryTextColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.favorite_border,
                color: AppColors.kPrimaryTextColor,
                size: 18,
              ),
              SizedBox(width: 4.w),
              Text(
                product.review ?? "", // Hardcoded from image
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.small.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Highlight Text
          if (product.description != null)
            Text(
              'Highly rated by customers for: ${product.description}',
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.small.value,
                color: AppColors.kPrimaryColor,
              ),
            ),
          SizedBox(height: 10.h),

          // Price and Payment Plan
          if (product.actualPrice != null)
            Text(
              '\$ ${product.actualPrice!.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: AppFontWeight.bold.value,
                fontSize: AppFontSize.large.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          SizedBox(height: 4.h),

          Row(
            children: [
              Text(
                'or 4 payments of \$ ${planAmount.toStringAsFixed(2)} with ',
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.medium.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
              Text(
                'Klarna',
                style: TextStyle(
                  fontWeight: AppFontWeight.bold.value,
                  fontSize: AppFontSize.small.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
              Icon(
                Icons.info_outline,
                size: 14.r,
                color: AppColors.kSecondaryTextColor,
              ),
              SizedBox(width: 4.w),
              // // Afterpay
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              //     decoration: BoxDecoration(
              //       color: AppColors.kPrimaryColor,
              //       borderRadius: BorderRadius.circular(4.r),
              //     ),
              //     child: Text(
              //       'Afterpay',
              //       style: TextStyle(
              //         fontWeight: AppFontWeight.bold.value,
              //         fontSize: AppFontSize.extraSmall.value,
              //         color: AppColors.kPrimaryBackgroundColor,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),

          // Auto-Replenish Save Text
          if (product.finalPrice != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text.rich(
                TextSpan(
                  text: 'Get It For ',
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    fontSize: AppFontSize.small.value,
                  ),
                  children: [
                    TextSpan(
                      text: '\$ ${product.finalPrice?.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: AppFontWeight.bold.value),
                    ),
                    TextSpan(
                      text: ' (5% Off) ', // Hardcoded 5% from image
                      style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontWeight: AppFontWeight.bold.value,
                      ),
                    ),
                    const TextSpan(text: 'With Auto-Replenish'),
                  ],
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
          SizedBox(height: 12.h),
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
          SizedBox(height: 8.h),
          if (product.id != null)
            Text(
              'Item ${product.id}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.small.value,
                color: AppColors.kSecondaryTextColor,
              ),
            ),

          SizedBox(height: 4.h),
          if (product.productDescription != null)
            Text(
              'What it is: ${product.productDescription}',
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.medium.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          SizedBox(height: 12.h),
          if (product.howToUse != null)
            Text(
              'How to use: ${product.howToUse}',
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.medium.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          SizedBox(height: 12.h),
          if (product.ingredients != null && product.ingredients!.isNotEmpty)
            Text(
              'Benefits: ${product.ingredients!.join(', ')}',
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.medium.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
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
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: product.imageUrl ?? "",
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.contain,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(color: Colors.grey[300]),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: Image.asset(Assets.noImages),
              ),
            ),
          ),

          _buildTopInfoSection(),

          Divider(
            height: 1,
            color: AppColors.kHintTextColor.withValues(alpha: 0.3),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                _buildOptionRow(
                  Icons.refresh,
                  'Auto-Replenish',
                  'Save 5% on this item',
                ),
                _buildOptionRow(
                  Icons.delivery_dining,
                  'Same-Day Delivery',
                  null,
                ),
                _buildOptionRow(Icons.storefront, 'Buy Online & Pick Up', null),
              ],
            ),
          ),

          _buildAboutProductSection(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildOptionRow(IconData icon, String title, String? subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: AppColors.kPrimaryTextColor, size: 24.sp),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.medium.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    fontSize: AppFontSize.small.value,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
