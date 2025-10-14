import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/app_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowTitleMessageSvgWidget extends StatelessWidget {
  final String? svgPath;
  final double? size;
  final String? title;
  final String? message;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onRefresh;
  final Widget? refreshWidget;

  const ShowTitleMessageSvgWidget({
    super.key,
    this.svgPath,
    this.size,
    this.title,
    this.message,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.onRefresh,
    this.refreshWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kPrimaryBackgroundColor,
      child: Center(
        child: Padding(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (svgPath != null)
                SvgPicture.asset(
                  svgPath!,
                  width: size ?? 200.w,
                  height: size ?? 250.h,
                  fit: BoxFit.cover,
                ),
              if (title?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    title!,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor ?? AppColors.kPrimaryColor,
                      fontSize: fontSize ?? AppFontSize.medium.value,
                      fontWeight: fontWeight ?? AppFontWeight.bold.value,
                    ),
                  ),
                ),
              if (message?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    message!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                    style: TextStyle(
                      color: textColor ?? AppColors.kPrimaryTextColor,
                      fontSize: fontSize ?? AppFontSize.small.value,
                      fontWeight: fontWeight ?? AppFontWeight.semiBold.value,
                    ),
                  ),
                ),
              SizedBox(height: 16.h),
              if (refreshWidget != null) ...[
                refreshWidget!,
              ] else if (onRefresh != null)
                InkWell(
                  onTap: onRefresh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 20.r,
                        color: AppColors.kIconPrimaryColor,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Refresh",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor ?? AppColors.kPrimaryColor,
                          fontSize: fontSize ?? AppFontSize.small.value,
                          fontWeight:
                              fontWeight ?? AppFontWeight.semiBold.value,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
