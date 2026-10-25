import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:flutter/material.dart';

class AEStoreLogo extends StatelessWidget {
  const AEStoreLogo({super.key, this.size = 164});

  final double size;

  @override
  Widget build(BuildContext context) {
    final markSize = size * 0.78;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.brandNavy.withValues(alpha: 0.2),
            blurRadius: size * 0.18,
            offset: Offset(0, size * 0.07),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Container(
        width: markSize,
        height: markSize,
        decoration: BoxDecoration(
          color: AppColors.brandLogoSurface,
          borderRadius: BorderRadius.circular(size * 0.18),
        ),
        alignment: Alignment.center,
        child: Text(
          'AE',
          style: AppStyles.style22Bold.copyWith(
            color: AppColors.onPrimary,
            fontSize: size * 0.29,
            fontWeight: FontWeight.w300,
            letterSpacing: -size * 0.03,
          ),
        ),
      ),
    );
  }
}
