import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Expanded(child: Divider(color: colors.borderSide)),
        const SizedBox(width: 12),
        Text(
          'Or Continue With',
          style: AppStyles.style13Regular.copyWith(color: colors.gray),
        ),
        const SizedBox(width: 12),
        Expanded(child: Divider(color: colors.borderSide)),
      ],
    );
  }
}
