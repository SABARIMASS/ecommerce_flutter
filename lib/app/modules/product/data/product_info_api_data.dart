class ProductInfoResponse {
  bool isLoading;
  bool isPaginationLoading = false;
  int? status;
  String? message;
  ProductInfoItem? responseData;

  ProductInfoResponse({
    this.isLoading = true,
    this.isPaginationLoading = false,
    this.status,
    this.message,
    this.responseData,
  });

  factory ProductInfoResponse.fromJson(Map<String, dynamic> json) {
    return ProductInfoResponse(
      isLoading: false,
      isPaginationLoading: false,
      status: json['status'] is int
          ? json['status']
          : int.tryParse('${json['status']}'),
      message: json['message'] is String ? json['message'] : null,
      responseData: json['responseData'] is Map
          ? ProductInfoItem.fromJson(json['responseData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'responseData': responseData?.toJson(),
  };
}

class ProductInfoItem {
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
  final String? review;

  ProductInfoItem({
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
    this.review,
  });

  factory ProductInfoItem.fromJson(Map json) {
    List<String> ingredientList = [];
    if (json['ingredients'] is List) {
      for (var ing in json['ingredients']) {
        if (ing is String) ingredientList.add(ing);
      }
    }

    return ProductInfoItem(
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
      review: json['review'] is String ? json['review'] : null,
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
class ProductInfoRequest {
  final String? id;

  ProductInfoRequest({this.id});

  Map<String, dynamic> toJson() => {'_id': id};
}
