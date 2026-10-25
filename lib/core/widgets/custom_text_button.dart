import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.textClr,
    required this.onPressed,
  });
  final String text;
  final Color? textClr;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppStyles.style16SemiBold.copyWith(
          color: textClr ?? AppColors.onBackground,
          fontFamily: "Manrope",
        ),
      ),
    );
  }
}
