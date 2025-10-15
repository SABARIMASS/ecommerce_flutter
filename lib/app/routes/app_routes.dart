import 'package:get/get.dart';
import '../bindings/app_binding.dart';
import '../modules/dashboard/view/dashboard_view.dart';
import '../modules/product/view/product_info_view.dart';
import '../modules/product/view/product_list_view.dart';
import '../modules/product/view/product_search_view.dart';

abstract class Routes {
  static const splashView = '/splashView';
  static const dashboardView = '/dashboardView';
  static const productListView = '/productListView';
  static const productSearchListView = '/productSearchListView';
  static const productInfoView = '/productInfoView';
}

class AppPages {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.dashboardView,
      page: () => DashBoardView(),
      binding: AppBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: Routes.productListView,
      page: () => ProductListView(),
      binding: AppBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: Routes.productSearchListView,
      page: () => ProductSearchView(),
      binding: AppBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: Routes.productInfoView,
      page: () => ProductInFoView(),
      binding: AppBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    // add more pages
  ];
}
