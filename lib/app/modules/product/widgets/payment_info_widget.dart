import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/app_style.dart';
import 'payment_option_wrap.dart'; // Import your existing PaymentInfoWrap

class PaymentInfoWidget extends StatelessWidget {
  final String totalAmount;
  final String installmentAmount;
  final int installmentCount;
  final String currency;
  final List<ItemData> paymentItems;

  const PaymentInfoWidget({
    super.key,
    required this.totalAmount,
    required this.installmentAmount,
    required this.installmentCount,
    required this.currency,
    required this.paymentItems,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          "$currency$totalAmount",
          style: TextStyle(
            color: AppColors.kPrimaryTextColor,
            fontSize: AppFontSize.extraSmall.value,
            fontWeight: AppFontWeight.bold.value,
          ),
        ),
        SizedBox(width: 4.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: Colors.blue.withValues(alpha: 0.1),
          ),
          child: Row(
            spacing: 4.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "or",
                style: TextStyle(
                  color: AppColors.kPrimaryTextColor,
                  fontSize: AppFontSize.extraSmall.value,
                  fontWeight: AppFontWeight.medium.value,
                ),
              ),
              Text(
                "$installmentCount Payments of $currency$installmentAmount",
                style: TextStyle(
                  color: AppColors.kPrimaryTextColor,
                  fontSize: AppFontSize.extraSmall.value,
                  fontWeight: AppFontWeight.semiBold.value,
                ),
              ),
              Text(
                "with",
                style: TextStyle(
                  color: AppColors.kPrimaryTextColor,
                  fontSize: AppFontSize.extraSmall.value,
                  fontWeight: AppFontWeight.medium.value,
                ),
              ),
            ],
          ),
        ),
        PaymentInfoWrap(items: paymentItems),
      ],
    );
  }
}
