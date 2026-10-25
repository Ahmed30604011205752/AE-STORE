import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class PasswordTextSection extends StatelessWidget {
  const PasswordTextSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.style28Bold.copyWith(
            fontFamily: "Manrope",
            color: AppColors.brandDialBlue,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: AppStyles.style14Regular.copyWith(
            color: AppColors.brandTextMuted,
          ),
        ),
      ],
    );
  }
}
