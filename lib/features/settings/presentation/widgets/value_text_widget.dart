import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class ValueTextWidget extends StatelessWidget {
  final String title;
  final String description;
  const ValueTextWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '• ',
            style: AppStyles.style14Regular.copyWith(
              color: AppColors.brandTextMuted,
            ),
          ),
          TextSpan(
            text: '$title ',
            style: AppStyles.style14Bold.copyWith(color: AppColors.brandInk),
          ),
          TextSpan(
            text: description,
            style: AppStyles.style13Regular.copyWith(
              color: AppColors.brandTextMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
