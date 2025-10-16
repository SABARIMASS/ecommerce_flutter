class ProductResponse {
  bool isLoading;
  bool isPaginationLoading;
  int? statusCode;
  bool? success;
  ProductData? responseData;
  Meta? meta;
  String? message;

  ProductResponse({
    this.isLoading = true,
    this.isPaginationLoading = false,
    this.statusCode,
    this.success,
    this.responseData,
    this.meta,
    this.message,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      isLoading: false,
      isPaginationLoading: false,
      statusCode: json['statusCode'] is int ? json['statusCode'] : null,
      success: json['success'] is bool ? json['success'] : null,
      responseData: json['data'] is Map
          ? ProductData.fromJson(json['data'])
          : null,
      meta: json['meta'] is Map ? Meta.fromJson(json['meta']) : null,
      message: json['message'] is String ? json['message'] : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'success': success,
    'data': responseData?.toJson(),
    'meta': meta?.toJson(),
  };
}

class ProductData {
  List<ProductItem>? products;

  ProductData({this.products});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    List<ProductItem> list = [];
    if (json['products'] is List) {
      for (var item in json['products']) {
        if (item is Map<String, dynamic>) {
          list.add(ProductItem.fromJson(item));
        }
      }
    }
    return ProductData(products: list);
  }

  Map<String, dynamic> toJson() => {
    'products': products?.map((e) => e.toJson()).toList(),
  };
}

class Meta {
  int? total;
  int? items;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Meta({this.total, this.items, this.perPage, this.currentPage, this.lastPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] is int ? json['total'] : null,
      items: json['items'] is int ? json['items'] : null,
      perPage: json['perPage'] is int ? json['perPage'] : null,
      currentPage: json['currentPage'] is int ? json['currentPage'] : null,
      lastPage: json['lastPage'] is int ? json['lastPage'] : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'items': items,
    'perPage': perPage,
    'currentPage': currentPage,
    'lastPage': lastPage,
  };
}

class ProductItem {
  String? id;
  String? title;
  String? description;
  String? handle;
  String? thumbnail;
  String? status;
  String? visibility;
  String? publishedAt;
  String? createdAt;
  double? averageRating;
  int? reviewsCount;
  int? ordersCount;
  Brand? brand;
  List<ProductCategoryItem>? productCategories;
  List<TagItem>? tags;
  List<VariantItem>? variants;
  List<ProductImage>? productImages;
  num? priceStart;
  num? priceEnd;
  bool isFav = false;

  ProductItem({
    this.id,
    this.title,
    this.description,
    this.handle,
    this.thumbnail,
    this.status,
    this.visibility,
    this.publishedAt,
    this.createdAt,
    this.averageRating,
    this.reviewsCount,
    this.ordersCount,
    this.brand,
    this.productCategories,
    this.tags,
    this.variants,
    this.productImages,
    this.priceStart,
    this.priceEnd,
    this.isFav = false,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    List<ProductCategoryItem> categoryList = [];
    if (json['productCategories'] is List) {
      for (var c in json['productCategories']) {
        if (c is Map<String, dynamic>) {
          categoryList.add(ProductCategoryItem.fromJson(c));
        }
      }
    }

    List<TagItem> tagList = [];
    if (json['tags'] is List) {
      for (var t in json['tags']) {
        if (t is Map<String, dynamic>) {
          tagList.add(TagItem.fromJson(t));
        }
      }
    }

    List<VariantItem> variantList = [];
    if (json['variants'] is List) {
      for (var v in json['variants']) {
        if (v is Map<String, dynamic>) {
          variantList.add(VariantItem.fromJson(v));
        }
      }
    }

    List<ProductImage> imageList = [];
    if (json['productImages'] is List) {
      for (var i in json['productImages']) {
        if (i is Map<String, dynamic>) {
          imageList.add(ProductImage.fromJson(i));
        }
      }
    }

    return ProductItem(
      id: json['id'] is String ? json['id'] : null,
      title: json['title'] is String ? json['title'] : null,
      description: json['description'] is String ? json['description'] : null,
      handle: json['handle'] is String ? json['handle'] : null,
      thumbnail: json['thumbnail'] is String ? json['thumbnail'] : null,
      status: json['status'] is String ? json['status'] : null,
      visibility: json['visibility'] is String ? json['visibility'] : null,
      publishedAt: json['publishedAt'] is String ? json['publishedAt'] : null,
      createdAt: json['createdAt'] is String ? json['createdAt'] : null,
      averageRating: json['averageRating'] is num
          ? json['averageRating'].toDouble()
          : null,
      reviewsCount: json['reviewsCount'] is int ? json['reviewsCount'] : null,
      ordersCount: json['ordersCount'] is int ? json['ordersCount'] : null,
      brand: json['brand'] is Map ? Brand.fromJson(json['brand']) : null,
      productCategories: categoryList,
      tags: tagList,
      variants: variantList,
      productImages: imageList,
      priceStart: json['priceStart'] is num ? json['priceStart'] : null,
      priceEnd: json['priceEnd'] is num ? json['priceEnd'] : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'handle': handle,
    'thumbnail': thumbnail,
    'status': status,
    'visibility': visibility,
    'publishedAt': publishedAt,
    'createdAt': createdAt,
    'averageRating': averageRating,
    'reviewsCount': reviewsCount,
    'ordersCount': ordersCount,
    'brand': brand?.toJson(),
    'productCategories': productCategories?.map((e) => e.toJson()).toList(),
    'tags': tags?.map((e) => e.toJson()).toList(),
    'variants': variants?.map((e) => e.toJson()).toList(),
    'productImages': productImages?.map((e) => e.toJson()).toList(),
    'priceStart': priceStart,
    'priceEnd': priceEnd,
  };
}

class Brand {
  String? id;
  String? handle;
  String? title;

  Brand({this.id, this.handle, this.title});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json['id'] is String ? json['id'] : null,
    handle: json['handle'] is String ? json['handle'] : null,
    title: json['title'] is String ? json['title'] : null,
  );

  Map<String, dynamic> toJson() => {'id': id, 'handle': handle, 'title': title};
}

class ProductCategoryItem {
  Category? category;

  ProductCategoryItem({this.category});

  factory ProductCategoryItem.fromJson(Map<String, dynamic> json) =>
      ProductCategoryItem(
        category: json['category'] is Map
            ? Category.fromJson(json['category'])
            : null,
      );

  Map<String, dynamic> toJson() => {'category': category?.toJson()};
}

class Category {
  String? id;
  String? name;
  String? handle;
  Category? parent;

  Category({this.id, this.name, this.handle, this.parent});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] is String ? json['id'] : null,
    name: json['name'] is String ? json['name'] : null,
    handle: json['handle'] is String ? json['handle'] : null,
    parent: json['parent'] is Map ? Category.fromJson(json['parent']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'handle': handle,
    'parent': parent?.toJson(),
  };
}

class TagItem {
  Tag? tag;

  TagItem({this.tag});

  factory TagItem.fromJson(Map<String, dynamic> json) =>
      TagItem(tag: json['tag'] is Map ? Tag.fromJson(json['tag']) : null);

  Map<String, dynamic> toJson() => {'tag': tag?.toJson()};
}

class Tag {
  String? id;
  String? title;
  String? slug;
  String? description;

  Tag({this.id, this.title, this.slug, this.description});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json['id'] is String ? json['id'] : null,
    title: json['title'] is String ? json['title'] : null,
    slug: json['slug'] is String ? json['slug'] : null,
    description: json['description'] is String ? json['description'] : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'description': description,
  };
}

class VariantItem {
  String? id;
  num? price;
  num? specialPrice;
  int? inventoryQuantity;
  num? originalPrice;
  num? currentPrice;

  VariantItem({
    this.id,
    this.price,
    this.specialPrice,
    this.inventoryQuantity,
    this.originalPrice,
    this.currentPrice,
  });

  factory VariantItem.fromJson(Map<String, dynamic> json) => VariantItem(
    id: json['id'] is String ? json['id'] : null,
    price: json['price'] is num ? json['price'] : null,
    specialPrice: json['specialPrice'] is num ? json['specialPrice'] : null,
    inventoryQuantity: json['inventoryQuantity'] is int
        ? json['inventoryQuantity']
        : null,
    originalPrice: json['originalPrice'] is num ? json['originalPrice'] : null,
    currentPrice: json['currentPrice'] is num ? json['currentPrice'] : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'price': price,
    'specialPrice': specialPrice,
    'inventoryQuantity': inventoryQuantity,
    'originalPrice': originalPrice,
    'currentPrice': currentPrice,
  };
}

class ProductImage {
  String? id;
  String? image;

  ProductImage({this.id, this.image});

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json['id'] is String ? json['id'] : null,
    image: json['image'] is String ? json['image'] : null,
  );

  Map<String, dynamic> toJson() => {'id': id, 'image': image};
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
