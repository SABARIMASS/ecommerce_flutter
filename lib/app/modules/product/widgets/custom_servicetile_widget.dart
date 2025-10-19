import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/app_style.dart';

class CustomServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const CustomServiceTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.kSecondaryBorderColor, width: 1.w),
      ),
      child: InkWell(
        onTap: onTap,
        // The content of the tile
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon section (Left)
              Icon(
                icon,
                size: 22.sp,
                color: AppColors.kGreyColor.withValues(
                  alpha: 0.6,
                ), // Using kGreyColor for the icons
              ),
              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      title,
                      style: appFont(
                        fontSize: AppFontSize.small,
                        fontWeight: AppFontWeight.semiBold,
                        color: AppColors.kPrimaryTextColor,
                      ),
                    ),

                    if (subtitle != null)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          subtitle!,
                          style: appFont(
                            fontSize: AppFontSize.extraSmall,
                            fontWeight: AppFontWeight.medium,
                            color: AppColors
                                .kPrimaryTextColor, // Grey hint color for subtitle
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductServiceOptions extends StatelessWidget {
  const ProductServiceOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      children: [
        CustomServiceTile(
          icon: Icons.cached_outlined,
          title: 'Auto-Replenish',
          subtitle: 'Save 5% on this item',
          onTap: () {},
        ),

        CustomServiceTile(
          icon: Icons.schedule_send_outlined, // Icon for Same-Day Delivery
          title: 'Same-Day Delivery',
          onTap: () {},
        ),

        CustomServiceTile(
          icon: Icons
              .store_mall_directory_outlined, // Icon for Buy Online & Pick Up
          title: 'Buy Online & Pick Up',
          onTap: () {},
        ),
      ],
    );
  }
}
