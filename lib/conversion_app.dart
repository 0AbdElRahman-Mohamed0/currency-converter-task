import 'package:currency_conversion/providers/currencies_provider.dart';
import 'package:currency_conversion/providers/data_provider.dart';
import 'package:currency_conversion/themes/app_theme.dart';
import 'package:currency_conversion/utils/app_strings.dart';
import 'package:currency_conversion/view/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class ConversionApp extends StatelessWidget {
  const ConversionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrenciesProvider>(
            create: (_) => CurrenciesProvider()),
        ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
