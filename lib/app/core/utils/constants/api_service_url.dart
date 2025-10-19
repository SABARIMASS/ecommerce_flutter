import 'package:sephora/app/core/helpers/app_info.dart';

class ApiServiceUrl {
  static const String productsListEndPoint =
      '${AppInfo.kAppBaseUrl}/store/product-search';
  static const String productsSearchListEndPoint =
      '${AppInfo.kAppBaseUrl}/store/product-search';
  static const String productDetailEndPoint =
      '${AppInfo.kAppBaseUrl}/store/product';
  static const String similarProductEndPoint =
      '${AppInfo.kAppBaseUrl}/store/product';
}
