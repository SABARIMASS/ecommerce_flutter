import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sephora/app/core/utils/constants/image_assets.dart';
import 'package:sephora/shared/app_style.dart';

class ProductRowTile extends StatelessWidget {
  final String productUrl;
  final String name;
  final String description;
  final VoidCallback? onTap;

  const ProductRowTile({
    super.key,
    required this.productUrl,
    required this.name,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryBackgroundColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: productUrl,
                height: 50.w,
                width: 50.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 50.w,
                    width: 50.w,
                    color: Colors.grey[300],
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 50.w,
                  width: 50.w,
                  color: Colors.grey[300],
                  child: Image.asset(Assets.noImages, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 10.w),

            // Name and Description
            Expanded(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
