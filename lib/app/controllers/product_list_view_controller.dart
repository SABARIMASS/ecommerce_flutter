import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/product_api_service.dart';
import '../modules/product/data/product_list_api_data.dart';

class ProductListViewController extends GetxController {
  Rx<ProductResponse> productResponse = ProductResponse().obs;
  Rx<ProductResponse> productSearchResponse = ProductResponse(
    isLoading: false,
  ).obs;
  final Rx<TextEditingController> searchController =
      TextEditingController().obs;
  var isSearchQueryEmpty = true.obs;
  @override
  void onClose() {
    searchController.value.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    fetchProductList();
    searchController.value.addListener(() {
      if (searchController.value.text.isEmpty) {
        isSearchQueryEmpty.value = true;
      } else {
        isSearchQueryEmpty.value = false;
      }
    });
    super.onInit();
  }
}

extension ProductListViewControllerExtension on ProductListViewController {
  void fetchProductList() async {
    productResponse.value.isLoading = true;
    productResponse.refresh();
    ProductApiService.productListApi(ProductRequest(limit: 10, page: 1))
        .then((response) {
          productResponse.value = response;
          productResponse.refresh();
        })
        .catchError((error) {
          productResponse.value = ProductResponse(
            isLoading: false,
            message: error.toString(),
            statusCode: 500,
          );
          productResponse.refresh();
        });
  }

  void fetchNextProductList() async {
    if (productResponse.value.meta?.currentPage ==
        productResponse.value.meta?.lastPage) {
      // No more pages to load
      return;
    }
    productResponse.value.isPaginationLoading = true;
    productResponse.refresh();
    ProductApiService.productListApi(
          ProductRequest(
            limit: 10,
            page: productResponse.value.meta?.currentPage != null
                ? ((productResponse.value.meta?.currentPage ?? 0) + 1)
                : 1,
          ),
        )
        .then((response) {
          productResponse.value.statusCode = response.statusCode;
          productResponse.value.message = response.message;
          productResponse.value.meta?.currentPage = response.meta?.currentPage;
          productResponse.value.meta?.lastPage = response.meta?.lastPage;
          // Append new products to existing list
          productResponse.value.isPaginationLoading = false;
          productResponse.value.responseData?.products?.addAll(
            response.responseData?.products ?? [],
          );
          productResponse.refresh();
        })
        .catchError((error) {
          //pagination error handling
          productResponse.value.isPaginationLoading = false;
          productResponse.refresh();
        });
  }

  void fetchSearchProductList() async {
    if (searchController.value.text.isEmpty) {
      productSearchResponse.value = ProductResponse(isLoading: false);
      productSearchResponse.refresh();
      return;
    }
    productSearchResponse.value.isLoading = true;
    productSearchResponse.refresh();
    ProductApiService.productSearchListApi(
          ProductRequest(
            limit: 10,
            page: 1,
            query: searchController.value.text,
          ),
        )
        .then((response) {
          productSearchResponse.value = response;
          productSearchResponse.refresh();
        })
        .catchError((error) {
          productSearchResponse.value = ProductResponse(
            isLoading: false,
            message: error.toString(),
            statusCode: 500,
          );
          productSearchResponse.refresh();
        });
  }

  void fetchSearchNextProductList() async {
    if (productSearchResponse.value.meta?.currentPage ==
        productSearchResponse.value.meta?.lastPage) {
      // No more pages to load
      return;
    }
    productSearchResponse.value.isPaginationLoading = true;
    productSearchResponse.refresh();
    ProductApiService.productSearchListApi(
          ProductRequest(
            limit: 10,
            page: productSearchResponse.value.meta?.currentPage != null
                ? ((productSearchResponse.value.meta!.currentPage ?? 0) + 1)
                : 1,
          ),
        )
        .then((response) {
          productSearchResponse.value.statusCode = response.statusCode;
          productSearchResponse.value.message = response.message;
          productSearchResponse.value.meta?.currentPage =
              response.meta?.currentPage;
          productSearchResponse.value.meta?.lastPage = response.meta?.lastPage;
          // Append new products to existing list
          productSearchResponse.value.isPaginationLoading = false;
          productSearchResponse.value.responseData?.products?.addAll(
            response.responseData?.products ?? [],
          );
          productSearchResponse.refresh();
        })
        .catchError((error) {
          //pagination error handling
          productSearchResponse.value.isPaginationLoading = false;
          productSearchResponse.refresh();
        });
  }
}
