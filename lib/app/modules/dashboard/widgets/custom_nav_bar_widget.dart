import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sephora/shared/app_style.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<NavItem> items = const [
    NavItem(label: "Home", icon: HugeIcons.strokeRoundedHome01),
    NavItem(label: "Shop", icon: HugeIcons.strokeRoundedShoppingBag01),
    NavItem(label: "Offers", icon: HugeIcons.strokeRoundedTag01),
    NavItem(label: "Me", icon: HugeIcons.strokeRoundedLeaf01),
    NavItem(label: "My Store", icon: HugeIcons.strokeRoundedHotel01),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.kSecondaryBorderColor.withValues(alpha: 0.3),
            width: 1,
          ), // top border only
        ),
        color: AppColors.kPrimaryBackgroundColor,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = selectedIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  onTap(index);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HugeIcon(
                        icon: item.icon,
                        color: isSelected
                            ? AppColors.kIconPrimaryColor
                            : AppColors.kHintTextColor,
                        size: 20.r,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: AppFontSize.extraSmall.value,
                          color: isSelected
                              ? AppColors.kIconPrimaryColor
                              : AppColors.kHintTextColor,
                          fontWeight: isSelected
                              ? AppFontWeight.semiBold.value
                              : AppFontWeight.normal.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class NavItem {
  final String label;
  final List<List<dynamic>> icon;
  const NavItem({required this.label, required this.icon});
}
