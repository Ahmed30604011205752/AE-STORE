import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.brandDialDeepBlue,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.brandDialSilver, width: 1.5),
      ),
      child: Column(children: children),
    );
  }
}
