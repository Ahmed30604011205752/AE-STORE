import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';

import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.brandDialMark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.brandButtonMuted),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 9, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Description", style: AppStyles.style16Bold),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_up),
                ),
              ],
            ),
            Text(
              description,
              style: AppStyles.style13Regular.copyWith(
                color: AppColors.secondary,
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
