import 'package:currency_conversion/utils/app_colors.dart';
import 'package:currency_conversion/utils/app_strings.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.secondary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffold,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    fontFamily: AppStrings.fontFamily,
    colorScheme: ColorScheme.dark(
      secondary: AppColors.secondary,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.secondary,
      ),
      bodySmall: const TextStyle(
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.border,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.border,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.border,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.border,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      contentPadding:
          const EdgeInsets.only(right: 16, left: 10, top: 10, bottom: 10),
    ),
  );
}
