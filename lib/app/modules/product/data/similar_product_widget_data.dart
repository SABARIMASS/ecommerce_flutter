import 'package:sephora/app/modules/product/data/product_list_api_data.dart';

class SimilarProductModel {
  final String imageUrl;
  final String id;
  final String reviewCount;
  final String name;
  final String description;
  final double rating;
  final num price;
  final String ingredientBalance;
  final ProductItem value;

  SimilarProductModel({
    required this.imageUrl,
    required this.id,
    required this.reviewCount,
    required this.name,
    required this.description,
    required this.rating,
    required this.price,
    required this.ingredientBalance,
    required this.value,
  });
}
