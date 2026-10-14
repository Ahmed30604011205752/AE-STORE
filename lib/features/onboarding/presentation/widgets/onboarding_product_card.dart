import 'dart:math' as math;

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
    final watchColor = [
      AppColors.brandStrapNavy,
      AppColors.brandStrapBrown,
      AppColors.brandStrapGreen,
    ][index];

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
                      style: AppTypography.labelSm.copyWith(
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
              child: CustomPaint(
                painter: _WatchPainter(strapColor: watchColor),
                child: const SizedBox.expand(),
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
                    style: AppTypography.labelMd.copyWith(
                      color: AppColors.brandInk,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  slide.series,
                  style: AppTypography.labelSm.copyWith(
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

class _WatchPainter extends CustomPainter {
  const _WatchPainter({required this.strapColor});

  final Color strapColor;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(size.width / 230, size.height / 300);
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const LinearGradient(
          colors: [
            AppColors.brandProductBackdrop,
            AppColors.brandProductBackdropMid,
            AppColors.brandProductBackdropEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Offset.zero & size),
    );
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2)
      ..scale(scale);

    final strapPaint = Paint()
      ..shader = LinearGradient(
        colors: [strapColor.withValues(alpha: 0.8), strapColor, strapColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(const Rect.fromLTWH(-45, -145, 90, 290));
    final strap = RRect.fromRectAndRadius(
      const Rect.fromLTRB(-40, -145, 40, 145),
      const Radius.circular(28),
    );
    canvas.drawRRect(strap, strapPaint);

    final seamPaint = Paint()
      ..color = AppColors.onPrimary.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTRB(-30, -132, 30, 132),
        const Radius.circular(20),
      ),
      seamPaint,
    );

    for (var y = -115; y <= 115; y += 22) {
      canvas.drawCircle(
        Offset(0, y.toDouble()),
        2,
        Paint()..color = AppColors.onPrimary.withValues(alpha: 0.38),
      );
    }

    canvas.drawCircle(
      const Offset(0, 0),
      83,
      Paint()
        ..color = AppColors.brandDialSilver
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8,
    );
    canvas.drawCircle(
      const Offset(0, 0),
      77,
      Paint()
        ..shader = const RadialGradient(
          colors: [AppColors.brandDialBlue, AppColors.brandDialDeepBlue],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: 77)),
    );

    final dialLine = Paint()
      ..color = AppColors.brandDialMark
      ..strokeWidth = 2;
    for (var i = 0; i < 12; i++) {
      final angle = i * math.pi / 6;
      final inner = Offset(math.sin(angle) * 60, -math.cos(angle) * 60);
      final outer = Offset(math.sin(angle) * 68, -math.cos(angle) * 68);
      canvas.drawLine(inner, outer, dialLine);
    }

    final handPaint = Paint()
      ..color = AppColors.brandDialGold
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawLine(Offset.zero, const Offset(-12, -42), handPaint)
      ..drawLine(Offset.zero, const Offset(37, 12), handPaint)
      ..drawCircle(Offset.zero, 4, Paint()..color = AppColors.brandDialGold);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WatchPainter oldDelegate) =>
      oldDelegate.strapColor != strapColor;
}
