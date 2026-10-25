import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:flutter/material.dart';

class SizeButton extends StatelessWidget {
  const SizeButton({
    super.key,
    required this.size,
    this.width = 30,
    this.height = 20,
    required this.onPressed,
    required this.isSelected,
  });
  final String size;
  final double width;
  final double height;
  final void Function()? onPressed;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          side: BorderSide(color: AppColors.brandButtonMuted),
          backgroundColor: isSelected ? AppColors.primary : AppColors.brandNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          size,
          style: AppStyles.style16Bold.copyWith(
            color: isSelected ? AppColors.background : AppColors.brandInk,
          ),
        ),
      ),
    );
  }
}
