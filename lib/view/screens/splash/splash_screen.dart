import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:currency_conversion/utils/asseta_extension.dart';
import 'package:currency_conversion/view/screens/conversion/conversion_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.transparent,
      splashIconSize: 200,
      duration: 600,
      animationDuration: const Duration(seconds: 3),
      splashTransition: SplashTransition.scaleTransition,
      splash: Image.asset('splash_logo'.toImage),
      nextScreen: const ConversionScreen(),
    );
  }
}
