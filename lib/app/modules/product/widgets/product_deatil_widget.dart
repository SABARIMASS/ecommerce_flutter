import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/app/core/helpers/app_info.dart';
import 'package:sephora/app/modules/product/data/product_detail_api_data.dart';

import 'package:sephora/app/modules/product/widgets/free_ship_widget.dart';
import 'package:sephora/shared/app_style.dart';
import '../../../core/utils/formate_strings_utils.dart';
import '../../../core/utils/percentage.dart';
import 'custom_servicetile_widget.dart';
import 'expandable_description_widget.dart';
import 'image_slider_widget.dart';
import 'payment_info_widget.dart';
import 'payment_option_wrap.dart';
import 'product_acordation_list.dart';
import 'product_price_info_widget.dart';
import 'product_review_summary_widget.dart';

class ProductDetailWidget extends StatefulWidget {
  final ProductData product;

  const ProductDetailWidget({super.key, required this.product});

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductDetailAndSubtitleWidget(widget: widget),
        SizedBox(height: 8.h),
        ProductReviewSummary(
          rating: widget.product.averageRating?.toDouble() ?? 0.0,
          reviewCount: NumberFormatter.formatNumber(
            widget.product.reviewsCount ?? 0,
          ),

          favoriteCount: NumberFormatter.formatNumber(
            widget.product.ordersCount ?? 0,
          ),
          ratedAttributes: ['coverage', 'satisfaction', 'application'],
        ),
        SizedBox(height: 8.h),

        PaymentInfoWidget(
          totalAmount:
              widget.product.variants != null &&
                  widget.product.variants!.isNotEmpty
              ? widget.product.variants!.first.price?.toStringAsFixed(1) ?? '0'
              : '0',
          installmentAmount: ProductHelpers.getPercentageAmount(
            widget.product.variants != null &&
                    widget.product.variants!.isNotEmpty
                ? widget.product.variants!.first.price ?? 0.0
                : 0.0,
            5,
          ).toStringAsFixed(2),
          installmentCount: 4,
          currency: AppInfo.kCurrency,

          paymentItems: [
            ItemData(name: 'Klarna'),
            ItemData(name: 'Paypal'),
          ],
        ),

        ProductPriceInfo(product: widget.product),
        SizedBox(height: 8.h),
        ProductImageCarousel(productImages: widget.product.productImages ?? []),
        SizedBox(height: 8.h),
        FreeShippingWidget(),
        SizedBox(height: 8.h),
        ProductServiceOptions(),
        SizedBox(height: 8.h),
        if (widget.product.description != null)
          ExpandableHtmlDescription(
            title: "About Product",
            description: widget.product.description!,
          ),
        SizedBox(height: 8.h),
        ProductAccordionList(tabs: widget.product.tabs ?? []),
        SizedBox(height: 8.h),
      ],
    );
  }
}

class ProductDetailAndSubtitleWidget extends StatelessWidget {
  const ProductDetailAndSubtitleWidget({super.key, required this.widget});

  final ProductDetailWidget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.title ?? '',
          style: TextStyle(
            color: AppColors.kPrimaryTextColor,
            fontSize: AppFontSize.extraSmall.value,
            fontWeight: AppFontWeight.bold.value,
          ),
        ),
        Visibility(
          visible:
              widget.product.description != null &&
              (widget.product.description?.isNotEmpty ?? false),
          child: Text(
            ProductHelpers.extractTextWithEntities(
              widget.product.description ?? '',
            ),
            maxLines: 2,
            style: TextStyle(
              color: AppColors.kPrimaryTextColor,
              fontSize: AppFontSize.extraSmall.value,
              fontWeight: AppFontWeight.medium.value,
            ),
          ),
        ),
      ],
    );
  }
}
