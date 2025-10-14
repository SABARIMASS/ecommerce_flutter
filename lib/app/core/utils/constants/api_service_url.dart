import 'package:sephora/app/core/helpers/app_info.dart';

class ApiServiceUrl {
  static const String productsListEndPoint =
      '${AppInfo.kAppBaseUrl}/api/products/list';
  static const String productsSearchListEndPoint =
      '${AppInfo.kAppBaseUrl}/api/products/search';
  static const String productsInfoEndPoint =
      '${AppInfo.kAppBaseUrl}/api/products/info';
}
