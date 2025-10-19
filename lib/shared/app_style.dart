import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Font Sizes
enum AppFontSize {
  extraSmall, // 10
  small, // 12
  medium, // 14
  large, // 16
  extraLarge, // 18
  extraExtraLarge, // 20
  huge, // 22
  extraHuge, // 24
}

extension FontSizeHelper on AppFontSize {
  double get value {
    switch (this) {
      case AppFontSize.extraSmall:
        return 10.sp;
      case AppFontSize.small:
        return 12.sp;
      case AppFontSize.medium:
        return 14.sp;
      case AppFontSize.large:
        return 16.sp;
      case AppFontSize.extraLarge:
        return 18.sp;
      case AppFontSize.extraExtraLarge:
        return 20.sp;
      case AppFontSize.huge:
        return 22.sp;
      case AppFontSize.extraHuge:
        return 24.sp;
    }
  }
}

/// Font Weights
enum AppFontWeight { light, normal, medium, semiBold, bold, extraBold }

extension FontWeightHelper on AppFontWeight {
  FontWeight get value {
    switch (this) {
      case AppFontWeight.light:
        return FontWeight.w300;
      case AppFontWeight.normal:
        return FontWeight.w400;
      case AppFontWeight.medium:
        return FontWeight.w500;
      case AppFontWeight.semiBold:
        return FontWeight.w600;
      case AppFontWeight.bold:
        return FontWeight.w800;
      case AppFontWeight.extraBold:
        return FontWeight.w800;
    }
  }
}

/// App Font Helper
TextStyle appFont({
  AppFontSize fontSize = AppFontSize.medium,
  AppFontWeight fontWeight = AppFontWeight.normal,
  Color? color,
  double? letterSpacing,
}) {
  return GoogleFonts.outfit(
    fontSize: fontSize.value,
    fontWeight: fontWeight.value,
    color: color,
    letterSpacing: letterSpacing,
  );
}

/// App Colors
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  static const Color kPrimaryColor = Color.fromARGB(255, 0, 0, 0);
  static const Color kSecondaryColor = Color.fromARGB(255, 255, 255, 255);

  static const Color kPrimaryBackgroundColor = Color.fromARGB(
    255,
    255,
    255,
    255,
  );
  static const Color kSecondaryBackgroundColor = Color.fromARGB(
    255,
    247,
    247,
    247,
  );

  static const Color kPrimaryTextColor = Color(0xFF212121);
  static const Color kSecondaryTextColor = Color.fromARGB(255, 255, 255, 255);

  static const Color kIconPrimaryColor = Color.fromARGB(255, 0, 0, 0);
  static const Color kIconSecondaryColor = Color.fromARGB(255, 255, 255, 255);

  static const Color kPrimaryBorderColor = Color.fromARGB(255, 0, 0, 0);
  static const Color kSecondaryBorderColor = Color.fromARGB(255, 197, 197, 197);

  static const Color kPrimaryButtonColor = Color.fromARGB(255, 0, 0, 0);
  static const Color kSecondaryButtonColor = Color.fromARGB(255, 255, 255, 255);

  static const Color kHintTextColor = Color(0xFF9E9E9E);
  static const Color kErrorColor = Color(0xFFD32F2F);

  static const Color kGreyColor = Color.fromARGB(255, 112, 112, 112);

  // Add more colors as needed
}
