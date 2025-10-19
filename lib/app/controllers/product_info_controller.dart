import 'package:get/get.dart';
import 'package:sephora/app/core/utils/logger_util.dart';
import '../modules/product/data/product_detail_api_data.dart';
import '../modules/product/data/product_list_api_data.dart';
import '../routes/app_routes.dart';
import '../services/product_api_service.dart';

class ProductInfoController extends GetxController {
  final ProductItem productId;
  ProductInfoController({required this.productId}) {}
  Rx<ProductItem>? argumentData = ProductItem().obs;
  Rx<ProductDetailResponse> productDetailResponse = ProductDetailResponse(
    isLoading: true,
  ).obs;
  Rx<ProductResponse> similarProductResponse = ProductResponse(
    isLoading: true,
  ).obs;

  @override
  void onInit() {
    fetchProductinfo();
    super.onInit();
  }

  void onSimilarProductTap(ProductItem value) {
    LoggerUtil.debug("Similar Product Tapped: ${value.id}");
    Get.toNamed(
      Routes.productInfoView,
      arguments: value,
      preventDuplicates: false,
    );
  }
}

extension ProductListViewControllerExtension on ProductInfoController {
  void fetchProductinfo() {
    if (Get.arguments is ProductItem) {
      argumentData?.value = Get.arguments as ProductItem;
      argumentData?.refresh();
    }
    fetchProductDetail();
    fetchSimilarProduct();
  }

  void fetchProductDetail() async {
    productDetailResponse.value.isLoading = true;
    productDetailResponse.refresh();
    ProductApiService.productDetail(handler: argumentData?.value.handle ?? '')
        .then((response) {
          productDetailResponse.value = response;
          productDetailResponse.refresh();
        })
        .catchError((error) {
          productDetailResponse.value = ProductDetailResponse(
            isLoading: false,
            message: 'Something went wrong',
            statusCode: 500,
          );
          productDetailResponse.refresh();
        });
  }

  void fetchSimilarProduct() async {
    similarProductResponse.value.isLoading = true;
    similarProductResponse.refresh();
    ProductApiService.similarProductApi(id: argumentData?.value.id ?? '')
        .then((response) {
          LoggerUtil.debug("SUCCESS");
          similarProductResponse.value = response;
          similarProductResponse.refresh();
        })
        .catchError((error) {
          similarProductResponse.value = ProductResponse(
            isLoading: false,
            message: 'Something went wrong',
            statusCode: 500,
          );
          similarProductResponse.refresh();
        });
  }
}
