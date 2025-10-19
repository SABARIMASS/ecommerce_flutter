import 'package:flutter/material.dart';
import 'package:sephora/shared/app_style.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final double iconSize;
  final Color filledColor;
  final Color emptyColor;

  const StarRating({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.iconSize = 16.0, // Small icon size (you specified 'small')
    this.filledColor = Colors.black, // Gold color for filled stars
    this.emptyColor =
        Colors.transparent, // Black color for the 'off' stars outline
  }) : assert(
         rating >= 0 && rating <= starCount,
         'Rating must be between 0 and starCount',
       );

  @override
  Widget build(BuildContext context) {
    // 1. Calculate the number of fully filled, half-filled, and empty stars
    int fullStars = rating.floor();
    bool hasHalfStar =
        (rating - fullStars) >= 0.50 && (rating - fullStars) < 0.95;
    int emptyStars = starCount - fullStars - (hasHalfStar ? 1 : 0);

    // 2. Build the list of star icons
    List<Widget> starList = [];

    // Add Fully Filled Stars
    for (int i = 0; i < fullStars; i++) {
      starList.add(Icon(Icons.star, color: filledColor, size: iconSize));
    }

    // Add Half-Filled Star (if needed)
    if (hasHalfStar) {
      starList.add(Icon(Icons.star_half, color: filledColor, size: iconSize));
    }

    // Add Empty/Outline Stars (the 'off' stars)
    for (int i = 0; i < emptyStars; i++) {
      starList.add(
        Icon(
          Icons.star_border, // Use the border icon for the black 'off' state
          color: AppColors.kPrimaryTextColor,
          size: iconSize,
        ),
      );
    }

    // 3. Return the Row containing the rating number and the stars
    return Row(
      mainAxisSize: MainAxisSize.min, // Keep the row size minimal
      children: [...starList],
    );
  }
}
