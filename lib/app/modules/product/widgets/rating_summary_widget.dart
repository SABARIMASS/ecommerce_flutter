import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/app_style.dart';

class RatingsSummaryWidget extends StatelessWidget {
  // Data passed into the constructor
  final String totalReviews;
  final double averageRating;
  final int totalRatingCount; // The 1,967 Reviews*
  final double recommendedPercentage;
  final Map<int, double>
  ratingDistribution; // Map of star rating (1-5) to its proportion/count

  const RatingsSummaryWidget({
    super.key,
    required this.totalReviews,
    required this.averageRating,
    required this.totalRatingCount,
    required this.recommendedPercentage,
    required this.ratingDistribution,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Ratings & Reviews (${totalReviews}K)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimaryTextColor,
              fontSize: AppFontSize.small.value,
            ),
          ),
          SizedBox(height: 10.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 2, child: _buildRatingBars()),
              SizedBox(width: 25.w),
              Expanded(flex: 1, child: _buildSummaryMetrics()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              averageRating.toStringAsFixed(1),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.kPrimaryTextColor,
                fontSize: AppFontSize.large.value,
              ),
            ),
            Icon(Icons.star, size: 22.r, color: Colors.black),
          ],
        ),
        Text(
          '${totalRatingCount.toString()} Reviews*',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryTextColor,
            fontSize: AppFontSize.extraSmall.value,
          ),
        ),
        SizedBox(height: 15.h),

        Text(
          '$recommendedPercentage%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryTextColor,
            fontSize: AppFontSize.large.value,
          ),
        ),
        Text(
          'Recommended',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryTextColor,
            fontSize: AppFontSize.extraSmall.value,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBars() {
    List<int> starOrder = [5, 4, 3, 2, 1];

    return Column(
      children: starOrder.map((star) {
        double proportion = ratingDistribution[star] ?? 0.0;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
                child: Text(
                  '$star',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryTextColor,
                    fontSize: AppFontSize.extraSmall.value,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(8.r),
                  value: proportion,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                  minHeight: 8,
                ),
              ),

              // if (proportion < 0.1)
              //   const Padding(
              //     padding: EdgeInsets.only(left: 4.0),
              //     child: Icon(Icons.circle, size: 5, color: Colors.black),
              //   ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
