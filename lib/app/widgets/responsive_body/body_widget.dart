import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/app_style.dart';
import 'widgets/body_data_handler.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
    required this.body,
    this.isLoading = false,
    this.noBodyData = false,
    this.showBodyWidget = true,
    //this.checkInternet = true,
    this.errorMessage,
    this.padding,
    this.color,
    this.noBodyWidget,
    this.loaderWidget,
    // this.autoRefresh,
  });
  final Widget body;
  final bool isLoading;
  //final bool checkInternet;
  final bool noBodyData;
  final bool showBodyWidget;
  final String? errorMessage;
  final Widget? loaderWidget;
  final Widget? noBodyWidget;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  //final void Function()? autoRefresh;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: color ?? AppColors.kPrimaryBackgroundColor,
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          child: BodyDataHandler(
            loaderWidget: loaderWidget,
            body: body,
            loader: isLoading,
            noBodyData: noBodyData,
            showBodyWidget: showBodyWidget,
            errorMessage: errorMessage,
            errorWidget: noBodyWidget,
          ),
        ),
      ),
    );
  }
}
