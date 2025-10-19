import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/app/modules/product/widgets/similar_product_card_widget.dart';
import '../../../../shared/app_style.dart';
import '../data/product_list_api_data.dart';
import '../data/similar_product_widget_data.dart';
import 'similar_product_label_widget.dart';

class ProductHorizontalList extends StatelessWidget {
  final String title;
  final List<SimilarProductModel> items;
  final void Function(ProductItem)? onTap;
  const ProductHorizontalList({
    super.key,
    required this.title,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: AppFontWeight.bold.value,
              fontSize: AppFontSize.small.value,
              color: AppColors.kPrimaryTextColor,
            ),
          ),
        ),

        /// Horizontal Scrollable Product List
        SizedBox(
          height: 300.h, // adjust based on your card height
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => SizedBox(width: 0.w),
            itemBuilder: (context, index) {
              final product = items[index];
              return Row(
                children: [
                  Visibility(
                    visible: index == 0,
                    child: SimilarProductLabelWidget(),
                  ),
                  SizedBox(
                    width: 150.w,
                    height: 300.h,
                    child: SimilarProductCard(
                      onTap: onTap,
                      value: product.value,
                      id: product.id,
                      reviewCount: product.reviewCount,
                      imageUrl: product.imageUrl,
                      name: product.name,
                      description: product.description,
                      rating: product.rating,
                      price: product.price,
                      ingredientBalance: product.ingredientBalance,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
