class ProductDetailResponse {
  final int? statusCode;
  final bool? success;
  final ProductData? data;
  final String? path;
  final String? message;
  final Map<String, dynamic>? meta;
  bool? isLoading;

  ProductDetailResponse({
    this.statusCode,
    this.success,
    this.data,
    this.path,
    this.message,
    this.meta,
    this.isLoading = true,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      statusCode: json['statusCode'],
      success: json['success'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
      path: json['path'],
      message: json['message'],
      meta: json['meta'],
      isLoading: false,
    );
  }
}

class ProductData {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? thumbnail;
  final String? handle;
  final String? status;
  final String? visibility;
  final int? reviewsCount;
  final double? averageRating;
  final int? ordersCount;
  final Brand? brand;
  final ProductMetadata? metadata;
  final List<ProductImage>? productImages;
  final List<ProductCategory>? productCategories;
  final List<ProductTag>? tags;
  final List<ProductVariant>? variants;
  final List<ProductOption>? options;
  final ProductAttributeGroup? productAttributeGroup;
  final List<ProductValueForAttribute>? productValuesForAttribute;
  final List<ProductTab>? tabs;
  final double? priceStart;
  final double? priceEnd;

  ProductData({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.thumbnail,
    this.handle,
    this.status,
    this.visibility,
    this.reviewsCount,
    this.averageRating,
    this.ordersCount,
    this.brand,
    this.metadata,
    this.productImages,
    this.productCategories,
    this.tags,
    this.variants,
    this.options,
    this.productAttributeGroup,
    this.productValuesForAttribute,
    this.tabs,
    this.priceStart,
    this.priceEnd,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      handle: json['handle'],
      status: json['status'],
      visibility: json['visibility'],
      reviewsCount: json['reviewsCount'],
      averageRating: (json['averageRating'] != null)
          ? double.tryParse(json['averageRating'].toString())
          : null,
      ordersCount: json['ordersCount'],
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      metadata: json['metadata'] != null
          ? ProductMetadata.fromJson(json['metadata'])
          : null,
      productImages: (json['productImages'] as List?)
          ?.map((e) => ProductImage.fromJson(e))
          .toList(),
      productCategories: (json['productCategories'] as List?)
          ?.map((e) => ProductCategory.fromJson(e))
          .toList(),
      tags: (json['tags'] as List?)
          ?.map((e) => ProductTag.fromJson(e))
          .toList(),
      variants: (json['variants'] as List?)
          ?.map((e) => ProductVariant.fromJson(e))
          .toList(),
      options: (json['options'] as List?)
          ?.map((e) => ProductOption.fromJson(e))
          .toList(),
      productAttributeGroup: json['productAttributeGroup'] != null
          ? ProductAttributeGroup.fromJson(json['productAttributeGroup'])
          : null,
      productValuesForAttribute: (json['productValuesForAttribute'] as List?)
          ?.map((e) => ProductValueForAttribute.fromJson(e))
          .toList(),
      tabs: (json['tabs'] as List?)
          ?.map((e) => ProductTab.fromJson(e))
          .toList(),
      priceStart: json['priceStart'] != null
          ? double.tryParse(json['priceStart'].toString())
          : null,
      priceEnd: json['priceEnd'] != null
          ? double.tryParse(json['priceEnd'].toString())
          : null,
    );
  }
}

class Brand {
  final String? id;
  final String? title;
  final String? description;
  final String? handle;
  final String? image;
  final String? status;

  Brand({
    this.id,
    this.title,
    this.description,
    this.handle,
    this.image,
    this.status,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      handle: json['handle'],
      image: json['image'],
      status: json['status'],
    );
  }
}

class ProductMetadata {
  final String? excerpt;

  ProductMetadata({this.excerpt});

  factory ProductMetadata.fromJson(Map<String, dynamic> json) {
    return ProductMetadata(excerpt: json['excerpt']);
  }
}

class ProductImage {
  final String? id;
  final String? image;
  final int? order;

  ProductImage({this.id, this.image, this.order});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      image: json['image'],
      order: json['order'],
    );
  }
}

class ProductCategory {
  final String? id;
  final String? productId;
  final String? categoryId;
  final Category? category;

  ProductCategory({this.id, this.productId, this.categoryId, this.category});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      productId: json['productId'],
      categoryId: json['categoryId'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
    );
  }
}

class Category {
  final String? id;
  final String? name;
  final String? description;
  final String? handle;
  final String? fullPath;
  final String? fullPathHandle;
  final Category? parent;

  Category({
    this.id,
    this.name,
    this.description,
    this.handle,
    this.fullPath,
    this.fullPathHandle,
    this.parent,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      handle: json['handle'],
      fullPath: json['fullPath'],
      fullPathHandle: json['fullPathHandle'],
      parent: json['parent'] != null ? Category.fromJson(json['parent']) : null,
    );
  }
}

class ProductTag {
  final String? id;
  final Tag? tag;

  ProductTag({this.id, this.tag});

  factory ProductTag.fromJson(Map<String, dynamic> json) {
    return ProductTag(
      id: json['id'],
      tag: json['tag'] != null ? Tag.fromJson(json['tag']) : null,
    );
  }
}

class Tag {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;

  Tag({this.id, this.title, this.slug, this.description});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
    );
  }
}

class ProductAttributeGroup {
  final String? id;
  final String? title;
  final String? code;

  ProductAttributeGroup({this.id, this.title, this.code});

  factory ProductAttributeGroup.fromJson(Map<String, dynamic> json) {
    return ProductAttributeGroup(
      id: json['id'],
      title: json['title'],
      code: json['code'],
    );
  }
}

class ProductValueForAttribute {
  final String? id;
  final ProductAttribute? productAttribute;
  final ProductAttributeValue? productAttributeValue;

  ProductValueForAttribute({
    this.id,
    this.productAttribute,
    this.productAttributeValue,
  });

  factory ProductValueForAttribute.fromJson(Map<String, dynamic> json) {
    return ProductValueForAttribute(
      id: json['id'],
      productAttribute: json['productAttribute'] != null
          ? ProductAttribute.fromJson(json['productAttribute'])
          : null,
      productAttributeValue: json['productAttributeValue'] != null
          ? ProductAttributeValue.fromJson(json['productAttributeValue'])
          : null,
    );
  }
}

class ProductAttribute {
  final String? code;

  ProductAttribute({this.code});

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(code: json['code']);
  }
}

class ProductAttributeValue {
  final String? value;

  ProductAttributeValue({this.value});

  factory ProductAttributeValue.fromJson(Map<String, dynamic> json) {
    return ProductAttributeValue(value: json['value']);
  }
}

class ProductTab {
  final String? id;
  final String? title;
  final String? content;

  ProductTab({this.id, this.title, this.content});

  factory ProductTab.fromJson(Map<String, dynamic> json) {
    return ProductTab(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}

class ProductVariant {
  final String? id;
  final String? sku;
  final double? price;
  final double? specialPrice;
  final double? originalPrice;
  final double? currentPrice;
  final String? thumbnail;
  final int? inventoryQuantity;

  ProductVariant({
    this.id,
    this.sku,
    this.price,
    this.specialPrice,
    this.originalPrice,
    this.currentPrice,
    this.thumbnail,
    this.inventoryQuantity,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      sku: json['sku'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      specialPrice: json['specialPrice'] != null
          ? double.tryParse(json['specialPrice'].toString())
          : null,
      originalPrice: json['originalPrice'] != null
          ? double.tryParse(json['originalPrice'].toString())
          : null,
      currentPrice: json['currentPrice'] != null
          ? double.tryParse(json['currentPrice'].toString())
          : null,
      thumbnail: json['thumbnail'],
      inventoryQuantity: json['inventoryQuantity'],
    );
  }
}

class ProductOption {
  final String? id;
  final String? title;
  final List<OptionValue>? values;

  ProductOption({this.id, this.title, this.values});

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    return ProductOption(
      id: json['id'],
      title: json['title'],
      values: (json['values'] as List?)
          ?.map((e) => OptionValue.fromJson(e))
          .toList(),
    );
  }
}

class OptionValue {
  final String? id;
  final String? value;

  OptionValue({this.id, this.value});

  factory OptionValue.fromJson(Map<String, dynamic> json) {
    return OptionValue(id: json['id'], value: json['value']);
  }
}
