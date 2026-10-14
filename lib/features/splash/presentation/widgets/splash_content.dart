import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/widgets/ae_store_logo.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
    required this.logoOpacity,
    required this.logoScale,
    required this.contentOpacity,
    required this.contentSlide,
    required this.onEnter,
  });

  final Animation<double> logoOpacity;
  final Animation<double> logoScale;
  final Animation<double> contentOpacity;
  final Animation<Offset> contentSlide;
  final VoidCallback onEnter;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight:
              MediaQuery.sizeOf(context).height -
              MediaQuery.paddingOf(context).vertical,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: contentOpacity,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.onPrimary.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 8,
                      color: AppColors.brandNavy,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "MAISON D'ÉLÉGANCE",
                      style: AppTypography.labelMd.copyWith(
                        color: AppColors.brandTextSoft,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 38),
            FadeTransition(
              opacity: logoOpacity,
              child: ScaleTransition(
                scale: logoScale,
                child: const AEStoreLogo(),
              ),
            ),
            const SizedBox(height: 34),
            SlideTransition(
              position: contentSlide,
              child: FadeTransition(
                opacity: contentOpacity,
                child: Column(
                  children: [
                    Text(
                      'AE STORE',
                      textAlign: TextAlign.center,
                      style: AppTypography.headlineLg.copyWith(
                        color: AppColors.brandInk,
                        fontSize: 29,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 2,
                      margin: const EdgeInsets.only(top: 8, bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.brandNavy,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Text(
                      'HAUTE HORLOGERIE & ACCESSORIES',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.brandTextSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2.2,
                      ),
                    ),
                    const SizedBox(height: 38),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: onEnter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandNavy,
                          foregroundColor: AppColors.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          elevation: 7,
                          shadowColor: AppColors.brandNavy.withValues(
                            alpha: 0.28,
                          ),
                          shape: const StadiumBorder(),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ENTER SALON',
                              style: AppTypography.labelLg.copyWith(
                                color: AppColors.onPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.arrow_forward, size: 19),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 54),
            FadeTransition(
              opacity: contentOpacity,
              child: Column(
                children: [
                  Text(
                    'GENÈVE  •  MILANO  •  PARIS',
                    style: AppTypography.labelMd.copyWith(
                      color: AppColors.brandTextFooter,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.brandEditionOverlay,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.lock_outline,
                            size: 12,
                            color: AppColors.brandTextMuted,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'EDITION V2.4',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.brandTextMuted,
                              fontSize: 10,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
