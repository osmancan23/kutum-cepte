import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kutum_cepte_app/core/init/theme/color/custom_color_scheme.dart';

class AppTextTheme {
  AppTextTheme._init();
  static AppTextTheme? _instance;

  static AppTextTheme? get instance {
    // ignore: join_return_with_assignment
    _instance ??= AppTextTheme._init();
    return _instance;
  }

  final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.urbanist(
      fontSize: 50.sp,
      fontWeight: FontWeight.w900,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    displayMedium: GoogleFonts.urbanist(
      fontSize: 45.sp,
      fontWeight: FontWeight.w900,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    displaySmall: GoogleFonts.urbanist(
      fontSize: 40.sp,
      fontWeight: FontWeight.w900,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    titleLarge: GoogleFonts.urbanist(
      fontSize: 35.sp,
      fontWeight: FontWeight.w700,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    titleMedium: GoogleFonts.urbanist(
      fontSize: 32.sp,
      fontWeight: FontWeight.w600,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    titleSmall: GoogleFonts.urbanist(
      fontSize: 30.sp,
      fontWeight: FontWeight.w500,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    headlineLarge: GoogleFonts.urbanist(
      fontSize: 25.sp,
      fontWeight: FontWeight.w700,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    headlineMedium: GoogleFonts.urbanist(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    headlineSmall: GoogleFonts.urbanist(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    bodyLarge: GoogleFonts.urbanist(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    bodyMedium: GoogleFonts.urbanist(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
    bodySmall: GoogleFonts.urbanist(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: CustomColorScheme.colorScheme.onPrimary,
    ),
  );
}
/*{
  FontWeight.w100: 'Thin',
  FontWeight.w200: 'ExtraLight',
  FontWeight.w300: 'Light',
  FontWeight.w400: 'Regular',
  FontWeight.w500: 'Medium',
  FontWeight.w600: 'SemiBold',
  FontWeight.w700: 'Bold',
  FontWeight.w800: 'ExtraBold',
  FontWeight.w900: 'Black',
} 
*/
