import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key, required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.brandBadge,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.circle, size: 6, color: AppColors.brandNavy),
                const SizedBox(width: 6),
                Text(
                  'AE STORE • EDITION 01',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.brandInk,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.brandButtonMuted,
              backgroundColor: AppColors.brandButtonSurface,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: const StadiumBorder(),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Skip',
                  style: AppTypography.labelMd.copyWith(fontSize: 11),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, size: 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
