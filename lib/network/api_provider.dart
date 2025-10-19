import 'package:get/get.dart';
import '../app/core/utils/logger_util.dart';

enum RequestType { kGet, kPost, kPut, kDelete }

class ApiProvider extends GetConnect {
  String token = '';

  @override
  void onInit() {
    super.onInit();
    httpClient.maxAuthRetries = 2;
  }

  Future<String> httpRequest({
    RequestType requestType = RequestType.kPost,
    required Resource resource,
    Map<String, String>? queryParam,
    Duration? timeout,
    FormData? formData,
  }) async {
    httpClient.timeout = timeout ?? const Duration(seconds: 60);

    LoggerUtil.logRequest(resource.url, body: resource.request);
    switch (requestType) {
      case RequestType.kGet:
        final response = await _get(resource, queryParam);
        LoggerUtil.logResponse(
          resource.url,
          statusCode: response.statusCode,
          responseBody: response.bodyString,
        );
        return response.bodyString ?? "";

      case RequestType.kPut:
        final response = await _put(resource, queryParam);
        LoggerUtil.logResponse(
          resource.url,
          statusCode: response.statusCode,
          responseBody: response.bodyString,
        );
        return response.bodyString ?? "";

      case RequestType.kDelete:
        final response = await _delete(resource, queryParam);
        LoggerUtil.logResponse(
          resource.url,
          statusCode: response.statusCode,
          responseBody: response.bodyString,
        );
        return response.bodyString ?? "";

      case RequestType.kPost:
        if (formData != null) {
          final response = await _postFormData(resource.url, formData);
          LoggerUtil.logResponse(
            resource.url,
            statusCode: response.statusCode,
            responseBody: response.bodyString,
          );
          return response.bodyString ?? "";
        } else {
          final response = await _post(resource, queryParam);
          LoggerUtil.logResponse(
            resource.url,
            statusCode: response.statusCode,
            responseBody: response.bodyString,
          );
          return response.bodyString ?? "";
        }
    }
  }
}

extension ApiMethods on ApiProvider {
  Future<Response> _delete(Resource resource, Map<String, String>? queryParam) {
    return httpClient.delete(resource.url, query: queryParam, headers: _header);
  }

  Future<Response> _put(Resource resource, Map<String, String>? queryParam) {
    return httpClient.put(
      resource.url,
      body: resource.request,
      query: queryParam,
      headers: _header,
    );
  }

  Future<Response> _post(Resource resource, Map<String, String>? queryParam) {
    return httpClient.post(
      resource.url,
      body: resource.request,
      query: queryParam,
      headers: _header,
    );
  }

  Map<String, String> get _header => {
    'Content-Type': 'application/json',
    'accept': '*/*',
  };

  Future<Response> _postFormData(String url, FormData formData) {
    return httpClient.post(
      url,
      body: formData,
      headers: _header,
      // headers: defaultApiHeaders(token, userVerifyHeader, form: true),
    );
  }

  Future<Response> _get(Resource resource, Map<String, String>? queryParam) {
    return httpClient.get(resource.url, query: queryParam, headers: _header);
  }
}

class Resource<T> {
  final String url;
  final String request;
  final T Function(Response response)? parse;

  Resource({required this.url, required this.request, this.parse});
}
