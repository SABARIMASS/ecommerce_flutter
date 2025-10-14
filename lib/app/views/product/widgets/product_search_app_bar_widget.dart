import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../shared/app_style.dart';

class CustomSearchBarAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onChanged;
  const CustomSearchBarAppBar({
    super.key,
    required this.controller,
    this.onSearch,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      surfaceTintColor: AppColors.kPrimaryBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            // SEARCH FIELD
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: onSearch,
                onChanged: onChanged,
                cursorColor: AppColors.kPrimaryColor,
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  color: AppColors.kPrimaryTextColor,
                  fontSize: AppFontSize.small.value,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  filled: true,
                  fillColor: AppColors.kSecondaryBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: AppColors.kPrimaryTextColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: AppColors.kPrimaryTextColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: AppColors.kPrimaryTextColor),
                  ),
                  constraints: BoxConstraints(maxHeight: 25.h, minHeight: 25.h),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedSearch01,
                      size: 18.r,
                      color: AppColors.kHintTextColor,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 25.w,
                    minHeight: 25.h,
                  ),
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 25.w,
                    minHeight: 25.h,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: InkWell(
                      onTap: () {
                        controller.clear();
                      },
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedCancelCircle,
                        size: 12.r,
                        color: AppColors.kHintTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 8.w),

            // CANCEL BUTTON
            GestureDetector(
              onTap: () {
                controller.clear();
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontSize: AppFontSize.small.value,
                  fontWeight: AppFontWeight.medium.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}
