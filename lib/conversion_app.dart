import 'package:currency_conversion/themes/app_theme.dart';
import 'package:currency_conversion/utils/app_strings.dart';
import 'package:currency_conversion/view/screens/conversion_screen.dart';
import 'package:flutter/material.dart';

class ConversionApp extends StatelessWidget {
  const ConversionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      home: const ConversionScreen(),
    );
  }
}
