import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/app_style.dart';

class PaymentInfoWrap extends StatelessWidget {
  final List<ItemData> items;

  const PaymentInfoWrap({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items.map((item) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // ✅ make the row shrink to its content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  color: AppColors.kPrimaryTextColor,
                  fontSize: AppFontSize.extraSmall.value,
                  fontWeight: AppFontWeight.semiBold.value,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.info_outline,
                size: 14.r,
                color: AppColors.kGreyColor.withValues(alpha: 0.6),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ItemData {
  final String name;

  ItemData({required this.name});
}
