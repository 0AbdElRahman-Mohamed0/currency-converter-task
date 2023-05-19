import 'package:currency_conversion/utils/dimensions.dart';
import 'package:currency_conversion/utils/empty_space_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPopUp extends StatelessWidget {
  final String message;

  const ErrorPopUp({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          24.ph,
          Text(
            message,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.w500),
          ),
          36.ph,
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          8.ph,
        ],
      ),
    );
  }
}
