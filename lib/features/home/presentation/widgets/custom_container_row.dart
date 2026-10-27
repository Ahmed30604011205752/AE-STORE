import 'package:ae_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.borderSide, width: 1.5),
      ),
      child: Column(children: children),
    );
  }
}
