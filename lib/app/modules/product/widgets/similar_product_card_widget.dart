import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/app/core/utils/constants/image_assets.dart' show Assets;
import 'package:shimmer/shimmer.dart';
import '../../../../shared/app_style.dart';
import '../../../core/helpers/app_info.dart';
import '../data/product_list_api_data.dart';

class SimilarProductCard extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String name;
  final String description;
  final double rating;
  final num price;
  final String ingredientBalance;
  final String reviewCount;
  final void Function(ProductItem id)? onTap;
  final ProductItem value;

  const SimilarProductCard({
    super.key,
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.price,
    required this.ingredientBalance,
    required this.reviewCount,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                      bottom: Radius.circular(12.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 100.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
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

                  /// Product Name
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: AppFontWeight.bold.value,
                      fontSize: AppFontSize.extraSmall.value,
                      color: AppColors.kPrimaryTextColor,
                    ),
                  ),

                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: AppFontWeight.medium.value,
                      fontSize: AppFontSize.extraSmall.value,
                      color: AppColors.kPrimaryTextColor,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: onTap != null ? () => onTap!(value) : null,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.kPrimaryBorderColor,
                          width: 1.5.h,
                        ),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Center(
                          child: Text(
                            "See Details",
                            style: TextStyle(
                              fontWeight: AppFontWeight.bold.value,
                              fontSize: AppFontSize.extraSmall.value,
                              color: AppColors.kPrimaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${AppInfo.kCurrency}${price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: AppFontWeight.bold.value,
                      fontSize: AppFontSize.extraSmall.value,
                      color: AppColors.kPrimaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider(color: AppColors.kGreyColor.withValues(alpha: 0.3)),

          /// Rating Row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              height: 20.h,
              child: Row(
                children: [
                  starRating(rating),
                  SizedBox(width: 4.w),
                  Text(
                    reviewCount,
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

          /// Price and Ingredient Balance
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ingredientBalance,
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: AppFontWeight.medium.value,
                          fontSize: AppFontSize.extraSmall.value,
                          color: AppColors.kPrimaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Star Rating Widget
  Widget starRating(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    List<Widget> stars = [];

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.black, size: 12.sp));
      stars.add(SizedBox(width: 1.w));
    }

    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.black, size: 12.sp));
      stars.add(SizedBox(width: 1.w));
    }

    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.black, size: 12.sp));
      if (i != emptyStars - 1) stars.add(SizedBox(width: 2.w));
    }

    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
