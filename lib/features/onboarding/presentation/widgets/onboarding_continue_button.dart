import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:flutter/material.dart';

class OnboardingContinueButton extends StatelessWidget {
  const OnboardingContinueButton({
    super.key,
    required this.onPressed,
    required this.isLastPage,
  });

  final VoidCallback onPressed;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandNavy,
          foregroundColor: AppColors.onPrimary,
          elevation: 5,
          shadowColor: AppColors.brandNavy.withValues(alpha: 0.25),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          shape: const StadiumBorder(),
        ),
        child: Row(
          children: [
            const Icon(Icons.volume_up_outlined, size: 17),
            const SizedBox(width: 10),
            Text(
              isLastPage ? 'Enter Salon' : 'Continue',
              style: AppStyles.style13Regular.copyWith(
                color: AppColors.onPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
            const Spacer(),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.onPrimary.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, size: 17),
            ),
          ],
        ),
      ),
    );
  }
}
