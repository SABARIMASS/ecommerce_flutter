import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main image
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 16.h),

            // Product name
            Container(
              height: 20.h,
              width: 0.7.sw, // 70% of screen width
              color: Colors.white,
            ),
            SizedBox(height: 12.h),

            // Rating & reviews
            Row(
              children: [
                Container(height: 16.h, width: 60.w, color: Colors.white),
                SizedBox(width: 12.w),
                Container(height: 16.h, width: 40.w, color: Colors.white),
              ],
            ),
            SizedBox(height: 16.h),

            // Description lines
            Container(
              height: 16.h,
              width: double.infinity,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(height: 16.h, width: 0.85.sw, color: Colors.white),
            SizedBox(height: 8.h),
            Container(height: 16.h, width: 0.6.sw, color: Colors.white),
            SizedBox(height: 24.h),

            // Bottom button
            Container(
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
