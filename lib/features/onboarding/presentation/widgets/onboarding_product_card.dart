import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/features/onboarding/data/models/onboarding_slide.dart';
import 'package:flutter/material.dart';

class OnboardingProductCard extends StatelessWidget {
  const OnboardingProductCard({
    super.key,
    required this.slide,
    required this.index,
  });

  final OnboardingSlide slide;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandNavy.withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.brandSoftBadge,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.blur_circular,
                      size: 11,
                      color: AppColors.brandNavy,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      slide.brand,
                      style: AppStyles.style13Regular.copyWith(
                        color: AppColors.primaryContainer,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 27,
                height: 27,
                decoration: const BoxDecoration(
                  color: AppColors.brandMutedBadge,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 14,
                  color: AppColors.brandInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                slide.image,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.brandBadge,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 7, color: AppColors.brandNavy),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    slide.product,
                    style: AppStyles.style13Regular.copyWith(
                      color: AppColors.brandInk,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  slide.series,
                  style: AppStyles.style13Regular.copyWith(
                    color: AppColors.brandTextMuted,
                    fontSize: 8,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
