class ProductResponse {
  bool isLoading;
  bool isPaginationLoading = false;
  int? status;
  String? message;
  ProductData? responseData;

  ProductResponse({
    this.isLoading = true,
    this.isPaginationLoading = false,
    this.status,
    this.message,
    this.responseData,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      isLoading: false,
      isPaginationLoading: false,
      status: json['status'] is int
          ? json['status']
          : int.tryParse('${json['status']}'),
      message: json['message'] is String ? json['message'] : null,
      responseData: json['responseData'] is Map
          ? ProductData.fromJson(json['responseData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'responseData': responseData?.toJson(),
  };
}

class ProductData {
  int? totalPages;
  int? currentPage;
  List<ProductItem>? products;

  ProductData({this.totalPages, this.currentPage, this.products});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    List<ProductItem> productList = [];
    if (json['products'] is List) {
      for (var item in json['products']) {
        if (item is Map) {
          productList.add(ProductItem.fromJson(item));
        }
      }
    }
    return ProductData(
      totalPages: json['totalPages'] is int
          ? json['totalPages']
          : int.tryParse('${json['totalPages']}'),
      currentPage: json['currentPage'] is int
          ? json['currentPage']
          : int.tryParse('${json['currentPage']}'),
      products: productList,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalPages': totalPages,
    'currentPage': currentPage,
    'products': products?.map((e) => e.toJson()).toList(),
  };
}

class ProductItem {
  final String? id;
  final String? productName;
  final String? description;
  final num? actualPrice;
  final num? finalPrice;
  final num? rating;
  final num? savingPercentage;
  final bool? isFav;
  final String? productDescription;
  final List<String>? ingredients;
  final String? howToUse;
  final String? imageUrl;

  ProductItem({
    this.id,
    this.productName,
    this.description,
    this.actualPrice,
    this.finalPrice,
    this.rating,
    this.savingPercentage,
    this.isFav,
    this.productDescription,
    this.ingredients,
    this.howToUse,
    this.imageUrl,
  });

  factory ProductItem.fromJson(Map json) {
    List<String> ingredientList = [];
    if (json['ingredients'] is List) {
      for (var ing in json['ingredients']) {
        if (ing is String) ingredientList.add(ing);
      }
    }

    return ProductItem(
      id: json['_id'] is String ? json['_id'] : null,
      productName: json['productName'] is String ? json['productName'] : null,
      description: json['description'] is String ? json['description'] : null,
      actualPrice: json['actualPrice'] is num
          ? json['actualPrice']
          : num.tryParse('${json['actualPrice']}'),
      finalPrice: json['finalPrice'] is num
          ? json['finalPrice']
          : num.tryParse('${json['finalPrice']}'),
      rating: json['rating'] is num
          ? json['rating']
          : num.tryParse('${json['rating']}'),
      savingPercentage: json['savingPercentage'] is num
          ? json['savingPercentage']
          : num.tryParse('${json['savingPercentage']}'),
      isFav: json['isFav'] is bool ? json['isFav'] : null,
      productDescription: json['productDescription'] is String
          ? json['productDescription']
          : null,
      ingredients: ingredientList,
      howToUse: json['howToUse'] is String ? json['howToUse'] : null,
      imageUrl: json['imageUrl'] is String ? json['imageUrl'] : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'productName': productName,
    'description': description,
    'actualPrice': actualPrice,
    'finalPrice': finalPrice,
    'rating': rating,
    'savingPercentage': savingPercentage,
    'isFav': isFav,
    'productDescription': productDescription,
    'ingredients': ingredients,
    'howToUse': howToUse,
    'imageUrl': imageUrl,
  };
}

/// Request class for pagination
class ProductRequest {
  final int? limit;
  final int? page;
  final String? query;

  ProductRequest({this.limit, this.page, this.query});

  Map<String, dynamic> toJson() => {
    'limit': limit,
    'page': page,
    'query': query,
  };
}
