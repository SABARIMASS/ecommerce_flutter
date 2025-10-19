import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sephora/app/modules/product/data/product_detail_api_data.dart';
import 'package:sephora/app/modules/product/data/product_list_api_data.dart'
    as list;
import 'package:sephora/app/widgets/shimmers/product_detail_widget.dart';
import '../../../../shared/app_style.dart';
import '../../../controllers/product_info_controller.dart';
import '../../../core/helpers/app_info.dart';
import '../../../core/utils/constants/image_assets.dart';
import '../../../core/utils/formate_strings_utils.dart';
import '../../../core/utils/percentage.dart';
import '../../../widgets/responsive_body/body_widget.dart';
import '../../../widgets/responsive_body/message_body_widgets/show_message_svg_widget.dart';
import '../../../widgets/shimmers/product_horizontal_shimmer_widget.dart';
import '../data/similar_product_widget_data.dart';
import '../widgets/product_deatil_widget.dart';
import '../widgets/rating_summary_widget.dart';
import '../widgets/similar_product_horizontal_scroll_widget.dart';

class ProductInFoView extends StatelessWidget {
  ProductInFoView({super.key});
  final controller = Get.find<ProductInfoController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.kPrimaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.kPrimaryBackgroundColor,
          surfaceTintColor: AppColors.kPrimaryBackgroundColor,
          elevation: 0,
          title: Text(
            controller.productDetailResponse.value.data?.title ??
                controller.argumentData?.value.title ??
                'Product Info',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimaryTextColor,
              fontSize: AppFontSize.medium.value,
            ),
          ),
          centerTitle: true,
        ),
        body: BodyWidget(
          isLoading: controller.productDetailResponse.value.isLoading ?? false,
          noBodyData: controller.productDetailResponse.value.data == null,
          loaderWidget: ProductDetailShimmer(),
          noBodyWidget: ShowMessageSvgWidget(
            size: 120.h,
            svgPath: Assets.noData,
            message: controller.productDetailResponse.value.data?.id == null
                ? "No Product Data"
                : "Something went wrong",
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          body: _bodyWidget(),
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductDetailWidget(
            product:
                controller.productDetailResponse.value.data ?? ProductData(),
          ),
          BodyWidget(
            padding: EdgeInsets.all(0),
            loaderWidget: ProductHorizonatlListShimmer(),
            isLoading: controller.similarProductResponse.value.isLoading,
            body: ProductHorizontalList(
              onTap: (value) {
                controller.onSimilarProductTap(value);
              },
              title: "Simialr Products",
              items:
                  controller.similarProductResponse.value.similarProduct?.map((
                    value,
                  ) {
                    return _similarData(value);
                  }).toList() ??
                  [],
            ),
          ),
          RatingsSummaryWidget(
            totalReviews: NumberFormatter.formatNumber(
              controller.productDetailResponse.value.data?.reviewsCount ?? 0,
            ),

            averageRating:
                controller.productDetailResponse.value.data?.averageRating
                    ?.toDouble() ??
                0.0,
            totalRatingCount:
                controller.productDetailResponse.value.data?.reviewsCount ?? 0,
            recommendedPercentage: ProductHelpers.ratingToPercentage(
              controller.productDetailResponse.value.data?.averageRating
                      ?.toDouble() ??
                  0.0,
            ),
            ratingDistribution: ProductHelpers.generateRealisticDistribution(
              controller.productDetailResponse.value.data?.averageRating
                      ?.toDouble() ??
                  0.0,
            ),
          ),
        ],
      ),
    );
  }

  SimilarProductModel _similarData(list.ProductItem value) {
    return SimilarProductModel(
      value: value,
      reviewCount: NumberFormatter.formatNumber(value.reviewsCount ?? 0),
      imageUrl:
          AppInfo.kImageBaseUrl +
          (value.productImages?.firstOrNull?.image?.toString() ?? ''),
      name: value.title ?? '',
      description: ProductHelpers.extractTextWithEntities(
        value.description ?? '',
      ),
      rating: value.averageRating?.toDouble() ?? 0.0,
      price: value.variants?.firstOrNull?.specialPrice ?? 0,
      ingredientBalance: (value.tags ?? [])
          .map((value) {
            return value.tag?.title ?? "";
          })
          .join(', '),
      id: value.handle.toString(),
    );
  }
}
