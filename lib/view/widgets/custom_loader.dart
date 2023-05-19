import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CustomLoader extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool isLoading;
  const CustomLoader(
      {required this.child, this.color, this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0.15,
      progressIndicator: SpinKitWave(
        color: color ?? Theme.of(context).primaryColor,
        size: 50.0,
      ),
      isLoading: isLoading,
      child: child,
    );
  }
}
