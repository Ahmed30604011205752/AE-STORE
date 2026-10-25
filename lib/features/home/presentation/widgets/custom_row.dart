import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Icon(icon, size: 28, color: colors.primary),

            const SizedBox(width: 10),

            Text(
              title,
              style: AppStyles.style16SemiBold.copyWith(color: colors.text),
            ),

            const Spacer(),

            trailing,
          ],
        ),
      ),
    );
  }
}
