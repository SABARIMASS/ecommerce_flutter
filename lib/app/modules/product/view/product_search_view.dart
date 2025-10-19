import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sephora/app/widgets/list_view/paginated_list.dart';
import '../../../../shared/app_style.dart';
import '../../../controllers/product_list_view_controller.dart';
import '../../../core/helpers/app_info.dart';
import '../../../core/utils/constants/image_assets.dart';
import '../../../core/utils/percentage.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/responsive_body/body_widget.dart';
import '../../../widgets/responsive_body/message_body_widgets/show_message_svg_widget.dart';
import '../../../widgets/shimmers/list_item_shimmer_widget.dart';
import '../widgets/product_search_app_bar_widget.dart';
import '../widgets/product_tile_widget.dart';
import '../widgets/trending_category_items_widget.dart';

class ProductSearchView extends StatelessWidget {
  ProductSearchView({super.key});
  final controller = Get.put(ProductListViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      appBar: CustomSearchBarAppBar(
        controller: controller.searchController.value,
        onChanged: (value) {
          controller.fetchSearchProductList();
        },
        onSearch: (query) {
          controller.historyManager.addQueryToHistory(query);
          controller.fetchSearchProductList();
          Get.back(result: true);
        },
      ),
      body: Obx(
        () => BodyWidget(
          isLoading: controller.productSearchResponse.value.isLoading,
          noBodyData: controller.productSearchResponse.value.statusCode != 200,
          loaderWidget: ListShimmer(itemCount: 10),
          noBodyWidget: controller.isSearchQueryEmpty.value
              ? SearchSuggestionsWidget(
                  trendingCategories: [
                    TrendingCategory(name: 'Gifts', icon: Icons.trending_up),
                    TrendingCategory(
                      name: 'Value & Gift Sets',
                      icon: Icons.trending_up,
                    ),
                    TrendingCategory(name: 'Eyebrow', icon: Icons.trending_up),
                    TrendingCategory(name: 'Makeup', icon: Icons.trending_up),
                    TrendingCategory(
                      name: 'Mini Size',
                      icon: Icons.trending_up,
                    ),
                  ],
                  previousSearches: controller.previousSearches,
                  onItemTap: (value) {
                    controller.searchController.value.text = value;
                    controller.historyManager.addQueryToHistory(value);
                    controller.fetchSearchProductList();
                    Get.back(result: true);
                  }, // Pass the callback function
                )
              : ShowMessageSvgWidget(
                  size: 120.h,
                  svgPath: Assets.noData,
                  message:
                      controller.productSearchResponse.value.message ??
                      "Something went wrong",
                ),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          body: PaginatedListView(
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
            listEmptyWidget: ShowMessageSvgWidget(
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

            itemBuilder: (context, index) {
              final product = controller
                  .productSearchResponse
                  .value
                  .responseData
                  ?.products?[index];
              return ProductRowTile(
                onTap: () {
                  Get.toNamed(Routes.productInfoView, arguments: product);
                },
                productUrl: AppInfo.kImageBaseUrl + (product?.thumbnail ?? ''),
                name: product?.title ?? '',
                description: ProductHelpers.extractTextWithEntities(
                  product?.description ?? '',
                ),
              );
            },
            separator: SizedBox(height: 8.h),
          ),
        ),
      ),
    );
  }
}
