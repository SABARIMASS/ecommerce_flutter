import 'package:get/get.dart';

import '../services/product_api_service.dart';
import '../modules/product/data/product_info_api_data.dart';

class ProductInfoController extends GetxController {
  Rx<ProductInfoResponse> productInfoResponse = ProductInfoResponse().obs;

  @override
  void onInit() {
    fetchProductinfo();
    super.onInit();
  }
}

extension ProductListViewControllerExtension on ProductInfoController {
  void fetchProductinfo() async {
    if (Get.arguments.toString().isEmpty) {
      productInfoResponse.value = ProductInfoResponse(
        isLoading: false,
        message: "Invalid Product ID",
        status: 400,
      );
      productInfoResponse.refresh();
      return;
    }
    productInfoResponse.value.isLoading = true;
    productInfoResponse.refresh();
    ProductApiService.productInfoApi(ProductInfoRequest(id: Get.arguments))
        .then((response) {
          productInfoResponse.value = response;
          productInfoResponse.refresh();
        })
        .catchError((error) {
          productInfoResponse.value = ProductInfoResponse(
            isLoading: false,
            message: error.toString(),
            status: 500,
          );
          productInfoResponse.refresh();
        });
  }
}
