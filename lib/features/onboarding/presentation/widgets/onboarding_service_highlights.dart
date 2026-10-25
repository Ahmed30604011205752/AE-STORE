import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:flutter/material.dart';

class OnboardingServiceHighlights extends StatelessWidget {
  const OnboardingServiceHighlights({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _ServiceHighlight(
            icon: Icons.verified_user_outlined,
            label: 'Authenticity\nGuaranteed',
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.circle, size: 4, color: AppColors.brandTextSubtle),
        ),
        Expanded(
          child: _ServiceHighlight(
            icon: Icons.local_shipping_outlined,
            label: 'Global White-Glove\nDelivery',
          ),
        ),
      ],
    );
  }
}

class _ServiceHighlight extends StatelessWidget {
  const _ServiceHighlight({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 13, color: AppColors.brandNavy),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: AppStyles.style13Regular.copyWith(
              color: AppColors.brandTextMuted,
              fontSize: 8,
              height: 1.25,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}
