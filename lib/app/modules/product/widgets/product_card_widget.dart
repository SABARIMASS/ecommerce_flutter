import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/app/core/utils/constants/image_assets.dart';
import 'package:sephora/shared/app_style.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final String productUrl;
  final String name;
  final String description;
  final double rating;
  final String review;
  final num price;
  final bool isFav;
  final String currency;
  final VoidCallback? onFavTap;
  final VoidCallback? onProductTap;

  const ProductCard({
    super.key,
    required this.productUrl,
    required this.name,
    required this.description,
    required this.rating,
    required this.review,
    required this.price,
    required this.isFav,
    required this.currency,
    this.onFavTap,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProductTap,
      child: Container(
        margin: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryBackgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            // First Expanded: Image
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: productUrl,
                      height: double.infinity,
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
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavTap,
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_outline,
                        size: 22.r,
                        color: isFav ? Colors.red : AppColors.kIconPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Second Expanded: Product Info
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: AppFontWeight.bold.value,
                        fontSize: AppFontSize.small.value,
                        color: AppColors.kPrimaryTextColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: AppFontWeight.medium.value,
                        fontSize: AppFontSize.extraSmall.value,
                        color: AppColors.kHintTextColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            starRating(rating),
                            SizedBox(width: 2.w),
                            Text(
                              review,
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
                    SizedBox(height: 2.h),
                    Text(
                      '$currency $price',
                      style: TextStyle(
                        fontWeight: AppFontWeight.bold.value,
                        fontSize: AppFontSize.medium.value,
                        color: AppColors.kPrimaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget starRating(double rating) {
    // Maximum 5 stars
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    List<Widget> stars = [];

    // Full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.black, size: 12.sp));
      stars.add(SizedBox(width: 1.w));
    }

    // Half star (optional, here using outlined star for simplicity)
    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.black, size: 12.sp));
      stars.add(SizedBox(width: 1.w));
    }

    // Empty stars
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.black, size: 12.sp));
      if (i != emptyStars - 1) stars.add(SizedBox(width: 2.w));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...stars,
        SizedBox(width: 4.w),
        // Text(rating.toStringAsFixed(1), style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
