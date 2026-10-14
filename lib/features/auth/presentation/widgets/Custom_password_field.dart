import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({
    super.key,
    required this.title,
    required this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.maxLines = 1,
    this.keyboardType,
    this.controller,
    this.validator,
  });
  final String title;
  final String hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: AppTypography.labelMd.copyWith(
            fontFamily: "Manrope",
            color: AppColors.primary,
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.brandButtonSurface,
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: AppTypography.bodyMd.copyWith(
              color: AppColors.brandTextMuted,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
