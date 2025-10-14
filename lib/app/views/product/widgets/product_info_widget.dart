import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/app_style.dart';
import '../../../core/utils/constants/image_assets.dart';
import '../data/product_info_api_data.dart';

// --- Custom Widget Combining All Sections ---

class CustomProductDetailWidget extends StatelessWidget {
  final ProductInfoItem product;

  const CustomProductDetailWidget({super.key, required this.product});

  // Helper: Top Product Info Section (Title, Rating, Price)
  Widget _buildTopInfoSection() {
    // Assuming a fixed payment plan (e.g., 4 payments of $X.XX) for this widget
    final double planAmount = (product.actualPrice ?? 16.00) / 4;

    Widget starRatingRow() {
      if (product.rating == null) return const SizedBox.shrink();
      int fullStars = product.rating!.floor();
      bool hasHalfStar = (product.rating! - fullStars) >= 0.5;
      int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

      List<Widget> stars = [];
      for (int i = 0; i < fullStars; i++) {
        stars.add(
          Icon(Icons.star, color: AppColors.kPrimaryTextColor, size: 14.sp),
        );
        stars.add(SizedBox(width: 1.w));
      }
      if (hasHalfStar) {
        stars.add(
          Icon(
            Icons.star_half,
            color: AppColors.kPrimaryTextColor,
            size: 14.sp,
          ),
        );
        stars.add(SizedBox(width: 1.w));
      }
      for (int i = 0; i < emptyStars; i++) {
        stars.add(
          Icon(
            Icons.star_border,
            color: AppColors.kPrimaryTextColor,
            size: 14.sp,
          ),
        );
        if (i != emptyStars - 1) stars.add(SizedBox(width: 1.w));
      }

      return Row(mainAxisSize: MainAxisSize.min, children: stars);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Collection & Product Name
          if (product.productName != null)
            Text(
              product.productName!,
              style: TextStyle(
                fontWeight: AppFontWeight.bold.value,
                fontSize: AppFontSize.large.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          SizedBox(height: 6.h),

          // Rating and Review
          Row(
            children: [
              if (product.rating != null) starRatingRow(),
              SizedBox(width: 4.w),
              if (product.rating != null)
                Text(
                  product.rating!.toString(),
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    fontSize: AppFontSize.small.value,
                    color: AppColors.kPrimaryTextColor,
                  ),
                ),
              SizedBox(width: 10.w),
              Text(
                'Ask a question',
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.small.value,
                  color: AppColors.kPrimaryTextColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.favorite_border,
                color: AppColors.kPrimaryTextColor,
                size: 18,
              ),
              SizedBox(width: 4.w),
              Text(
                '139.1K', // Hardcoded from image
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.small.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Highlight Text
          if (product.description != null)
            Text(
              'Highly rated by customers for: ${product.description}',
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.small.value,
                color: AppColors.kPrimaryColor,
              ),
            ),
          SizedBox(height: 10.h),

          // Price and Payment Plan
          if (product.actualPrice != null)
            Text(
              '\$ ${product.actualPrice!.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: AppFontWeight.bold.value,
                fontSize: AppFontSize.large.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          SizedBox(height: 4.h),

          Row(
            children: [
              Text(
                'or 4 payments of \$ ${planAmount.toStringAsFixed(2)} with ',
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.medium.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
              const Text(
                'Klarna',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.info_outline,
                size: 16.sp,
                color: AppColors.kSecondaryTextColor,
              ),
              SizedBox(width: 8.w),
              // Afterpay
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Afterpay',
                  style: TextStyle(
                    fontWeight: AppFontWeight.bold.value,
                    fontSize: AppFontSize.extraSmall.value,
                    color: AppColors.kPrimaryBackgroundColor,
                  ),
                ),
              ),
              Icon(
                Icons.info_outline,
                size: 16.sp,
                color: AppColors.kSecondaryTextColor,
              ),
            ],
          ),

          // Auto-Replenish Save Text
          if (product.finalPrice != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text.rich(
                TextSpan(
                  text: 'Get It For ',
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    fontSize: AppFontSize.small.value,
                  ),
                  children: [
                    TextSpan(
                      text: '\$ ${product.finalPrice?.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: AppFontWeight.bold.value),
                    ),
                    TextSpan(
                      text: ' (5% Off) ', // Hardcoded 5% from image
                      style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontWeight: AppFontWeight.bold.value,
                      ),
                    ),
                    const TextSpan(text: 'With Auto-Replenish'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper: About the Product Section
  Widget _buildAboutProductSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Divider(height: 1, color: AppColors.kPrimaryColor),
          SizedBox(height: 16.h),
          Text(
            'About the Product',
            style: TextStyle(
              fontWeight: AppFontWeight.bold.value,
              fontSize: AppFontSize.large.value,
              color: AppColors.kPrimaryTextColor,
            ),
          ),
          SizedBox(height: 8.h),
          if (product.id != null)
            Text(
              'Item ${product.id}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.small.value,
                color: AppColors.kSecondaryTextColor,
              ),
            ),

          SizedBox(height: 4.h),
          if (product.productDescription != null)
            Text(
              'What it is: ${product.productDescription}',
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.medium.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          SizedBox(height: 12.h),
          if (product.howToUse != null)
            Text(
              'How to use: ${product.howToUse}',
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.medium.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
          SizedBox(height: 12.h),
          if (product.ingredients != null && product.ingredients!.isNotEmpty)
            Text(
              'Benefits: ${product.ingredients!.join(', ')}',
              style: TextStyle(
                fontWeight: AppFontWeight.medium.value,
                fontSize: AppFontSize.medium.value,
                color: AppColors.kPrimaryTextColor,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: product.imageUrl ?? "",
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(color: Colors.grey[300]),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: Image.asset(Assets.noImages),
              ),
            ),
          ),
          // 1. Top Product Info (Title, Price, Payment Plan)
          _buildTopInfoSection(),

          // ---
          const Divider(height: 1, color: AppColors.kHintTextColor),
          // ---

          // 2. Options (Auto-Replenish, Same-Day Delivery, Buy Online & Pick Up)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                _buildOptionRow(
                  Icons.refresh,
                  'Auto-Replenish',
                  'Save 5% on this item',
                ),
                _buildOptionRow(
                  Icons.delivery_dining,
                  'Same-Day Delivery',
                  null,
                ),
                _buildOptionRow(Icons.storefront, 'Buy Online & Pick Up', null),
              ],
            ),
          ),

          // ---

          // 4. About the Product
          _buildAboutProductSection(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // Helper for Auto-Replenish/Delivery/Pickup Rows
  Widget _buildOptionRow(IconData icon, String title, String? subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: AppColors.kPrimaryTextColor, size: 24.sp),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: AppFontWeight.medium.value,
                  fontSize: AppFontSize.medium.value,
                  color: AppColors.kPrimaryTextColor,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    fontSize: AppFontSize.small.value,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Usage Example ---
/*
// To use this in your app:

void main() {
  // Initialize ScreenUtil (required for .w, .h, .sp extensions)
  // Ensure you wrap your app in ScreenUtilInit
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Standard mobile design size
      builder: (context, child) => MaterialApp(
        title: 'Sephora Mockup',
        theme: ThemeData(primarySwatch: Colors.red),
        home: const ProductDetailPage(),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  // Example data instantiation (using defaults set in the model)
  final productData = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPHORA'),
        actions: const [
          Icon(Icons.favorite_border),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: CustomProductDetailWidget(product: productData),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        color: AppColors.kPrimaryBackgroundColor,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kDividerColor),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                children: [
                  Text('1', style: TextStyle(fontWeight: AppFontWeight.bold.value)),
                  Icon(Icons.keyboard_arrow_down, size: 20.sp),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                child: Text(
                  'Add to Basket',
                  style: TextStyle(
                    color: AppColors.kPrimaryBackgroundColor,
                    fontWeight: AppFontWeight.bold.value,
                    fontSize: AppFontSize.medium.value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
