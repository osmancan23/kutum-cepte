import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kutum_cepte_app/core/init/theme/color/custom_color_scheme.dart';
import 'package:kutum_cepte_app/core/init/theme/text/text_theme.dart';

class AppTheme {
  AppTheme._init();
  static AppTheme? _instance;
  static AppTheme? get instance {
    // ignore: join_return_with_assignment
    _instance ??= AppTheme._init();
    return _instance;
  }

  ThemeData theme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true, backgroundColor: Colors.transparent),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    scaffoldBackgroundColor: CustomColorScheme.colorScheme.onError,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
    progressIndicatorTheme: const ProgressIndicatorThemeData(),
    dividerTheme: DividerThemeData(color: Colors.white.withOpacity(0.2)),
    textTheme: AppTextTheme.instance?.textTheme,
    colorScheme: CustomColorScheme.colorScheme,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: CustomColorScheme.colorScheme.primaryContainer,
      hintStyle: AppTextTheme.instance?.textTheme.bodySmall?.copyWith(color: Colors.red),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: CustomColorScheme.colorScheme.primaryContainer,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: CustomColorScheme.colorScheme.primaryContainer,
      dialHandColor: CustomColorScheme.colorScheme.primary,
      dialBackgroundColor: CustomColorScheme.colorScheme.primaryContainer,
      hourMinuteColor: CustomColorScheme.colorScheme.primary,
      hourMinuteTextColor: CustomColorScheme.colorScheme.primaryContainer,
      dayPeriodShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      hourMinuteShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(fontSize: 12.sp, color: CustomColorScheme.colorScheme.error),
    ),
  );
}
