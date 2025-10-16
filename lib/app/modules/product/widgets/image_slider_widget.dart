import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart' show CarouselSlider;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/helpers/app_info.dart';
import '../../../core/utils/constants/image_assets.dart';
import '../data/product_list_api_data.dart';

class ProductImageCarousel extends StatefulWidget {
  final ProductItem product;

  const ProductImageCarousel({super.key, required this.product});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Create the list of image URLs
    final List<String> imageUrls = [
      if (widget.product.thumbnail != null &&
          widget.product.thumbnail!.isNotEmpty)
        widget.product.thumbnail!,
      if (widget.product.productImages != null &&
          widget.product.productImages!.isNotEmpty)
        ...widget.product.productImages!.map((img) => img.image ?? ""),
    ].where((url) => url.isNotEmpty).toList();

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 210.h,
              viewportFraction: 1.0,
              enableInfiniteScroll: imageUrls.length > 1,
              autoPlay: imageUrls.length > 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageUrls.map((imageUrl) {
              return CachedNetworkImage(
                imageUrl: AppInfo.kImageBaseUrl + imageUrl,
                width: double.infinity,
                fit: BoxFit.contain,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.grey[300]),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Image.asset(Assets.noImages),
                ),
              );
            }).toList(),
          ),
        ),
        // Dots indicators on top of image
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageUrls.asMap().entries.map((entry) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.black
                      : Colors.grey[400],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
