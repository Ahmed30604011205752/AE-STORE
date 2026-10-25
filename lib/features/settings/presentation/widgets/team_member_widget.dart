import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class TeamMemberWidget extends StatelessWidget {
  final String name;
  final String role;
  const TeamMemberWidget({super.key, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: const AssetImage('assets/images/hour.png'),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: AppStyles.style13Bold.copyWith(color: AppColors.brandInk),
        ),
        const SizedBox(height: 2),
        Text(
          role,
          style: AppStyles.style12Regular.copyWith(
            color: AppColors.brandTextMuted,
          ),
        ),
      ],
    );
  }
}
