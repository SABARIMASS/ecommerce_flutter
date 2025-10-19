import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sephora/app/controllers/product_list_view_controller.dart';
import 'package:sephora/app/core/helpers/app_info.dart';
import 'package:sephora/app/core/utils/constants/image_assets.dart';
import 'package:sephora/app/modules/product/widgets/custom_search_app_bar_widget.dart';
import 'package:sephora/app/modules/product/widgets/product_card_widget.dart';
import 'package:sephora/app/widgets/list_view/paginated_grid.dart';
import 'package:sephora/app/widgets/responsive_body/body_widget.dart';
import 'package:sephora/app/widgets/responsive_body/message_body_widgets/show_message_svg_widget.dart';
import 'package:sephora/app/widgets/shimmers/product_shimmer.dart';
import '../../../../shared/app_style.dart';
import '../../../core/utils/percentage.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/safe_area_container.dart';
import 'product_search_view.dart';

class ProductListView extends StatelessWidget {
  ProductListView({super.key});
  final controller = Get.put(ProductListViewController());
  @override
  Widget build(BuildContext context) {
    return SafeAreaContainer(
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryBackgroundColor,
        appBar: CustomSearchAppBar(
          controller: controller.searchController.value,
          onSearchTap: () async {
            final result = await Get.to(
              () => ProductSearchView(),
              transition: Transition.fadeIn,
            );
            if (result != true) {
              controller.searchController.value.clear();
              controller.productSearchResponse.value.responseData?.products
                  ?.clear();
              controller.productSearchResponse.refresh();
            }
          },
        ),
        body: Obx(
          () => controller.isSearchQueryEmpty.value
              ? _productListWidget()
              : _searchpProductListWidget(),
        ),
      ),
    );
  }

  BodyWidget _productListWidget() {
    return BodyWidget(
      isLoading: controller.productResponse.value.isLoading,
      noBodyData: controller.productResponse.value.statusCode != 200,
      loaderWidget: GridShimmer(itemCount: 10),
      noBodyWidget: ShowMessageSvgWidget(
        size: 120.h,
        svgPath: Assets.noData,
        message:
            controller.productResponse.value.message ?? "Something went wrong",
        onRefresh: () {
          controller.fetchProductList();
        },
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      body: PaginatedGridView(
        onRefresh: () async {
          controller.fetchProductList();
        },
        isLoading: controller.productResponse.value.isLoading,
        itemCount:
            controller.productResponse.value.responseData?.products?.length ??
            0,
        backgroundColor: AppColors.kPrimaryBackgroundColor,
        emptyMessage: "No Products Found",
        gridEmptyWidget: ShowMessageSvgWidget(
          size: 120.h,
          svgPath: Assets.noData,
          message: "No Products Found",
        ),
        isPaginationLoading:
            controller.productResponse.value.isPaginationLoading,
        paginationOver:
            controller.productResponse.value.meta?.currentPage ==
            controller.productResponse.value.meta?.lastPage,
        onPagination: () {
          controller.fetchNextProductList();
        },
        paginationErrorMessage: null,
        onPaginationRetry: null,
        padding: EdgeInsets.symmetric(horizontal: 0),
        aspectRatio: 0.56,
        crossAxisSpacing: 0.w,
        mainAxisSpacing: 0.h,

        itemBuilder: (context, index) {
          final product =
              controller.productResponse.value.responseData?.products?[index];
          return ProductCard(
            productUrl: AppInfo.kImageBaseUrl + (product?.thumbnail ?? ''),
            name: product?.title ?? '',
            description: ProductHelpers.extractTextWithEntities(
              product?.description ?? '',
            ),
            rating: product?.averageRating?.toDouble() ?? 0.0,

            price: product?.variants?.firstOrNull?.specialPrice ?? 0,
            total: product?.variants?.firstOrNull?.price ?? 0,
            isFav: product?.isFav ?? false,
            currency: AppInfo.kCurrency,
            onFavTap: () {
              controller
                      .productResponse
                      .value
                      .responseData
                      ?.products?[index]
                      .isFav =
                  !(controller
                          .productResponse
                          .value
                          .responseData
                          ?.products?[index]
                          .isFav ??
                      false);

              controller.productResponse.refresh();
            },
            onProductTap: () {
              Get.toNamed(Routes.productInfoView, arguments: product);
            },
          );
        },
      ),
    );
  }

  BodyWidget _searchpProductListWidget() {
    return BodyWidget(
      isLoading: controller.productSearchResponse.value.isLoading,
      noBodyData: controller.productSearchResponse.value.statusCode != 200,
      noBodyWidget: ShowMessageSvgWidget(
        svgPath: Assets.noData,
        size: 120.h,
        message:
            controller.productSearchResponse.value.message ??
            "Something went wrong",
        onRefresh: () {
          controller.fetchSearchNextProductList();
        },
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      body: PaginatedGridView(
        onRefresh: () async {
          controller.fetchSearchProductList();
        },
        isLoading: controller.productSearchResponse.value.isLoading,
        itemCount:
            controller
                .productSearchResponse
                .value
                .responseData
                ?.products
                ?.length ??
            0,
        backgroundColor: AppColors.kPrimaryBackgroundColor,
        emptyMessage: "No Products Found",
        gridEmptyWidget: ShowMessageSvgWidget(
          size: 120.h,
          svgPath: Assets.noData,
          message: "No Products Found",
        ),
        isPaginationLoading:
            controller.productSearchResponse.value.isPaginationLoading,
        paginationOver:
            controller.productSearchResponse.value.meta?.currentPage ==
            controller.productSearchResponse.value.meta?.lastPage,
        onPagination: () {
          controller.fetchSearchNextProductList();
        },
        paginationErrorMessage: null,
        onPaginationRetry: null,
        padding: EdgeInsets.symmetric(horizontal: 0),
        aspectRatio: 0.56,
        crossAxisSpacing: 0.w,
        mainAxisSpacing: 0.h,
        itemBuilder: (context, index) {
          final product = controller
              .productSearchResponse
              .value
              .responseData
              ?.products?[index];
          return ProductCard(
            productUrl: AppInfo.kImageBaseUrl + (product?.thumbnail ?? ''),
            name: product?.title ?? '',
            description: ProductHelpers.extractTextWithEntities(
              product?.description ?? '',
            ),
            rating: product?.averageRating?.toDouble() ?? 0.0,

            price: product?.variants?.firstOrNull?.specialPrice ?? 0,
            total: product?.variants?.firstOrNull?.price ?? 0,
            isFav: product?.isFav ?? false,
            currency: AppInfo.kCurrency,
            onFavTap: () {
              controller
                      .productSearchResponse
                      .value
                      .responseData
                      ?.products?[index]
                      .isFav =
                  !(controller
                          .productSearchResponse
                          .value
                          .responseData
                          ?.products?[index]
                          .isFav ??
                      false);

              controller.productSearchResponse.refresh();
            },
            onProductTap: () {
              Get.toNamed(Routes.productInfoView, arguments: product);
            },
          );
        },
      ),
    );
  }
}
