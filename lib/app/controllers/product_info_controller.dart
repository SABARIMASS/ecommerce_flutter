import 'package:get/get.dart';
import '../modules/product/data/product_list_api_data.dart';

class ProductInfoController extends GetxController {
  Rx<ProductItem>? productInfoResponse = ProductItem().obs;

  @override
  void onInit() {
    fetchProductinfo();
    super.onInit();
  }
}

extension ProductListViewControllerExtension on ProductInfoController {
  void fetchProductinfo() async {
    if (Get.arguments is ProductItem) {
      productInfoResponse?.value = Get.arguments as ProductItem;
      productInfoResponse?.refresh();
      return;
    }
  }
}
