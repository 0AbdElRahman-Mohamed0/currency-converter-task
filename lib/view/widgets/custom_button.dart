import 'package:currency_conversion/utils/app_colors.dart';
import 'package:currency_conversion/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.title, this.onTap})
      : super(key: key);

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: Dimensions.PADDING_SIZE_SUPER_EXTRA_LARGE,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
