import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_styles.dart';
import 'package:ae_store/core/widgets/ae_store_logo.dart';
import 'package:flutter/material.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AEStoreLogo(size: 120),
        const SizedBox(height: 12),
        Text(
          'AE STORE',
          style: AppStyles.style16Bold.copyWith(color: AppColors.brandNavy),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: AppStyles.style24Bold.copyWith(
            fontFamily: "Manrope",
            color: AppColors.brandDialBlue,
          ),
        ),
        SizedBox(height: 8),
        Text(
          subTitle,
          style: AppStyles.style14Regular.copyWith(
            color: AppColors.brandTextMuted,
          ),
        ),
      ],
    );
  }
}
