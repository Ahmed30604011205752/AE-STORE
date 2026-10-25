// Custom widget: 4-segment bar that shows how strong the password is
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class PasswordBar extends StatelessWidget {
  const PasswordBar({
    super.key,
    required this.filledCount,
    required this.label,
    required this.color,
  });

  final int filledCount; // how many of 4 segments are filled (0-4)
  final String label; // e.g. "Strong password" or "Excellent password"
  final Color color; // color for filled segments and label text

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          spacing: 6,
          children: List.generate(4, (i) {
            return Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: i < filledCount
                      ? color
                      : AppColors.brandTextMuted.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          label,

          style: AppStyles.style13Regular.copyWith(
            fontFamily: "Manrope",
            color: color,
          ),
        ),
      ],
    );
  }
}
