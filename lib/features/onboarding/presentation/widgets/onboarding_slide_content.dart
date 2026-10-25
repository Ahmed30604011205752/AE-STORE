import 'package:ae_store/features/onboarding/data/models/onboarding_slide.dart';
import 'package:ae_store/features/onboarding/presentation/widgets/onboarding_product_card.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:flutter/material.dart';

class OnboardingSlideContent extends StatelessWidget {
  const OnboardingSlideContent({
    super.key,
    required this.slide,
    required this.index,
  });

  final OnboardingSlide slide;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: OnboardingProductCard(slide: slide, index: index),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.brandLavenderBadge,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 13,
                color: AppColors.brandNavy,
              ),
              const SizedBox(width: 6),
              Text(
                slide.eyebrow,
                style: AppStyles.style13Regular.copyWith(
                  color: AppColors.brandNavy,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          slide.title,
          textAlign: TextAlign.center,
          style: AppStyles.style22Bold.copyWith(
            color: AppColors.brandInk,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            slide.description,
            textAlign: TextAlign.center,
            style: AppStyles.style13Regular.copyWith(
              color: AppColors.brandTextSoft,
              fontSize: 12,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}
