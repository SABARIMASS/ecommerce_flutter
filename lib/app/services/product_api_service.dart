import 'dart:convert';
import 'package:get/get.dart';
import '../../network/api_provider.dart';
import '../core/utils/constants/api_service_url.dart';
import '../modules/product/data/product_info_api_data.dart';
import '../modules/product/data/product_list_api_data.dart';

class ProductApiService {
  static final ApiProvider apiProvider = GetInstance().put(ApiProvider());
  static Future<ProductResponse> productListApi(ProductRequest request) async {
    try {
      final response = await apiProvider.httpRequest(
        resource: Resource(
          url: ApiServiceUrl.productsListEndPoint,
          request: '',
        ),
        queryParam: {
          "limit": request.limit.toString(),
          "page": request.page.toString(),
        },
        requestType: RequestType.kGet,
      );

      return ProductResponse.fromJson(json.decode(response));
    } catch (e) {
      throw "Something went wrong";
    }
  }

  static Future<ProductResponse> productSearchListApi(
    ProductRequest request,
  ) async {
    try {
      final response = await apiProvider.httpRequest(
        resource: Resource(
          url: ApiServiceUrl.productsSearchListEndPoint,
          request: '',
        ),
        queryParam: {
          "limit": request.limit.toString(),
          "page": request.page.toString(),
          'query': request.query ?? '',
        },
        requestType: RequestType.kGet,
      );

      return ProductResponse.fromJson(json.decode(response));
    } catch (e) {
      throw "Something went wrong";
    }
  }

  static Future<ProductInfoResponse> productInfoApi(
    ProductInfoRequest request,
  ) async {
    try {
      final response = await apiProvider.httpRequest(
        resource: Resource(
          url: '${ApiServiceUrl.productsInfoEndPoint}/${request.id}',
          request: jsonEncode(request.toJson()),
        ),
        requestType: RequestType.kGet,
      );

      return ProductInfoResponse.fromJson(json.decode(response));
    } catch (e) {
      throw "Something went wrong";
    }
  }
}
