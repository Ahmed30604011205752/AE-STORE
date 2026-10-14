import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.brandButtonMuted)),
        Text(
          '   Or Continue With   ',
          style: AppTypography.bodySm.copyWith(
            color: AppColors.brandButtonMuted,
          ),
        ),
        Expanded(child: Divider(color: AppColors.brandButtonMuted)),
      ],
    );
  }
}
