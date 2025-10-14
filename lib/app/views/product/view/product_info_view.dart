import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../shared/app_style.dart';
import '../../../controllers/product_info_controller.dart';
import '../../../core/utils/constants/image_assets.dart';
import '../../../widgets/responsive_body/body_widget.dart';
import '../../../widgets/responsive_body/message_body_widgets/show_message_svg_widget.dart';
import '../widgets/product_info_widget.dart';

class ProductInFoView extends GetView<ProductInfoController> {
  const ProductInFoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryBackgroundColor,
        surfaceTintColor: AppColors.kPrimaryBackgroundColor,
        elevation: 0,
        title: Text(
          'Product Details',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryTextColor,
            fontSize: AppFontSize.medium.value,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => BodyWidget(
          isLoading: controller.productInfoResponse.value.isLoading,
          noBodyData: controller.productInfoResponse.value.status != 1,
          noBodyWidget: ShowMessageSvgWidget(
            size: 120.h,
            svgPath: Assets.noData,
            message:
                controller.productInfoResponse.value.message ??
                "Something went wrong",
          ),
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          body: controller.productInfoResponse.value.responseData != null
              ? CustomProductDetailWidget(
                  product: controller.productInfoResponse.value.responseData!,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
