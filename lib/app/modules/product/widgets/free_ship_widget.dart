import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/app_style.dart';

class FreeShippingWidget extends StatelessWidget {
  const FreeShippingWidget({super.key});

  TextSpan _buildLinkSpan({required String text, required VoidCallback onTap}) {
    return TextSpan(
      text: text,
      style: appFont(
        fontSize: AppFontSize.small,
        fontWeight: AppFontWeight.normal,
        color: Colors.blue.shade700,
        letterSpacing: 0,
      ).copyWith(decoration: TextDecoration.underline),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.kPrimaryBorderColor, width: 1.5.w),
      ),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 22.sp,
                  color: AppColors.kPrimaryColor,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Sign in',
                      style: appFont(
                        fontSize: AppFontSize.small,
                        fontWeight: AppFontWeight.semiBold,
                        color: Colors.blue.shade700,
                        letterSpacing: 0,
                      ).copyWith(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      children: <TextSpan>[
                        TextSpan(
                          text: ' for ',
                          style: appFont(
                            fontSize: AppFontSize.small,
                            fontWeight: AppFontWeight.normal,
                            color: AppColors.kPrimaryTextColor,
                          ),
                        ),
                        TextSpan(
                          text: 'FREE shipping',
                          style: appFont(
                            fontSize: AppFontSize.small,
                            fontWeight: AppFontWeight.bold,
                            color: AppColors.kPrimaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: AppColors.kGreyColor.withValues(alpha: 0.1),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      style: appFont(
                        fontSize: AppFontSize.small,
                        fontWeight: AppFontWeight.normal,
                        color: AppColors.kPrimaryTextColor,
                        letterSpacing: 0.1,
                      ),
                      children: <TextSpan>[
                        _buildLinkSpan(text: 'Sign in', onTap: () {}),
                        const TextSpan(text: ' or '),
                        _buildLinkSpan(text: 'create an account', onTap: () {}),
                        TextSpan(text: ' to enjoy '),
                        TextSpan(
                          text: 'FREE',
                          style: appFont(
                            fontSize: AppFontSize.small,
                            fontWeight: AppFontWeight.bold,
                            color: AppColors.kPrimaryTextColor,
                          ),
                        ),
                        const TextSpan(text: ' standard shipping.'),
                      ],
                    ),
                  ),
                  //SizedBox(height: 6.h),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Shipping & Returns',
                      style: appFont(
                        fontSize: AppFontSize.small,
                        fontWeight: AppFontWeight.normal,
                        color: Colors.blue.shade700,
                      ).copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
