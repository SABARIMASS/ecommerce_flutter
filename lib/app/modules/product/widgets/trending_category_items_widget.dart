import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/shared/app_style.dart';

class TrendingCategoryItem extends StatelessWidget {
  final TrendingCategory category;
  final VoidCallback onTap;

  const TrendingCategoryItem({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        child: Row(
          children: <Widget>[
            Icon(category.icon, size: 16.r, color: Colors.black),

            SizedBox(width: 12.w),
            Text(
              category.name,
              style: TextStyle(
                fontSize: AppFontSize.extraSmall.value,
                fontWeight: FontWeight.bold,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviousSearchItem extends StatelessWidget {
  final String searchText;
  final VoidCallback onTap; // Callback for when the item is tapped

  const PreviousSearchItem({
    super.key,
    required this.searchText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            searchText,
            style: TextStyle(
              fontSize: AppFontSize.extraSmall.value,
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimaryTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchSuggestionsWidget extends StatelessWidget {
  final List<TrendingCategory> trendingCategories;
  final List<String> previousSearches;
  final Function(String query) onItemTap;

  const SearchSuggestionsWidget({
    super.key,
    required this.trendingCategories,
    required this.previousSearches,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 11.w,
              vertical: 4.h,
            ),
            child: Text(
              'Trending Categories',
              style: TextStyle(
                fontSize: AppFontSize.small.value,
                fontWeight: FontWeight.bold,
                color: AppColors.kGreyColor,
              ),
            ),
          ),
          ...trendingCategories.map(
            (category) => TrendingCategoryItem(
              category: category,
              onTap: () => onItemTap(category.name),
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 11.w,
              vertical: 4.h,
            ),
            child: Text(
              'Previous Searches',
              style: TextStyle(
                fontSize: AppFontSize.small.value,
                fontWeight: FontWeight.bold,
                color: AppColors.kGreyColor,
              ),
            ),
          ),
          ...previousSearches.map(
            (search) => PreviousSearchItem(
              searchText: search,
              onTap: () => onItemTap(search),
            ),
          ),
        ],
      ),
    );
  }
}

class TrendingCategory {
  final String name;
  final IconData icon;

  TrendingCategory({required this.name, required this.icon});
}
