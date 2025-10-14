import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sephora/shared/app_style.dart';

final ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: AppColors.kPrimaryColor,
  scaffoldBackgroundColor: AppColors.kPrimaryBackgroundColor,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  primaryTextTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black54,
    selectionColor: Color(0xCC000000), // ~ alpha 0.8
    selectionHandleColor: Color(0xB3000000), // ~ alpha 0.7
  ),
);

final ThemeData themeDataDark = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: AppColors.kPrimaryColor,
  scaffoldBackgroundColor: AppColors.kPrimaryBackgroundColor,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  primaryTextTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black54,
    selectionColor: Color(0xCC000000), // ~ alpha 0.8
    selectionHandleColor: Color(0xB3000000), // ~ alpha 0.7
  ),
);
