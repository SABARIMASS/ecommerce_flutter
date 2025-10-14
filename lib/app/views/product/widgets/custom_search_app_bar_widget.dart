import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../shared/app_style.dart';

class CustomSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController controller;
  final VoidCallback? onSearchTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onHeartTap;
  final VoidCallback? onBudgetTap;

  const CustomSearchAppBar({
    super.key,
    required this.controller,
    this.onSearchTap,
    this.onChanged,
    this.onSubmitted,
    this.onHeartTap,
    this.onBudgetTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.kPrimaryBackgroundColor,
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      elevation: 0,
      title: Row(
        children: [
          Text(
            'S E P H O R A',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimaryTextColor,
              fontSize: AppFontSize.medium.value,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: onSearchTap,
              child: AbsorbPointer(
                // disables typing but keeps visual style
                child: TextField(
                  readOnly: true, // ensures non-editable behavior
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    color: AppColors.kPrimaryTextColor,
                    fontSize: AppFontSize.small.value,
                  ),
                  controller: controller,
                  textInputAction: TextInputAction.done,
                  cursorHeight: 12.h,
                  cursorColor: AppColors.kPrimaryColor,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 25.h,
                      minHeight: 25.h,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 18.h,
                      minHeight: 18.h,
                      maxWidth: 33.w,
                      minWidth: 33.w,
                    ),
                    prefixIcon: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedSearch01,
                        size: 18.r,
                        color: AppColors.kHintTextColor,
                      ),
                    ),
                    hintText: 'Search',
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    filled: true,
                    fillColor: AppColors.kSecondaryBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: AppColors.kPrimaryTextColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: AppColors.kPrimaryTextColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: AppColors.kPrimaryTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: onHeartTap,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedFavourite,
              size: 22.r,
              color: AppColors.kIconPrimaryColor,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onBudgetTap,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingBag01,
              size: 22.r,
              color: AppColors.kIconPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
