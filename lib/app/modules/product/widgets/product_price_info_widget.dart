import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/app/modules/product/data/product_detail_api_data.dart';
import '../../../../shared/app_style.dart';
import '../../../core/helpers/app_info.dart';
import '../../../core/utils/percentage.dart';

class ProductPriceInfo extends StatelessWidget {
  final ProductData product;

  const ProductPriceInfo({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the first variant if exists
    final variant = product.variants != null && product.variants!.isNotEmpty
        ? product.variants!.first
        : null;

    final double originalPrice = variant?.price ?? 0.0;
    final double specialPrice = variant?.specialPrice ?? 0.0;

    // Calculate offer percentage
    final double offer = ProductHelpers.calculateOfferPercentage(
      originalPrice,
      specialPrice,
    );

    return Visibility(
      visible: specialPrice > 0,
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Get it For",
              style: TextStyle(
                color: AppColors.kPrimaryTextColor,
                fontSize: AppFontSize.extraSmall.value,
                fontWeight: AppFontWeight.semiBold.value,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              "${AppInfo.kCurrency}${specialPrice.toStringAsFixed(1)}",
              style: TextStyle(
                color: AppColors.kPrimaryTextColor,
                fontSize: AppFontSize.extraSmall.value,
                fontWeight: AppFontWeight.semiBold.value,
              ),
            ),
            if (offer > 0) ...[
              SizedBox(width: 4.w),
              Text(
                "(${offer.toStringAsFixed(0)}% off)",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: AppFontSize.extraSmall.value,
                  fontWeight: AppFontWeight.bold.value,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
