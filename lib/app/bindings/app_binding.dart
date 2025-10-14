import 'package:get/get.dart';
import '../../network/api_provider.dart';
import '../controllers/dashboard_view_controller.dart';
import '../controllers/product_info_controller.dart';
import '../controllers/product_list_view_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<ProductInfoController>(() => ProductInfoController());
    Get.lazyPut<ProductListViewController>(() => ProductListViewController());
  }
}
