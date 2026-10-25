import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
  });
  final String text;
  final String iconPath;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        side: BorderSide(color: Colors.grey),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
      onPressed: onPressed,
      icon: SizedBox(width: 25, height: 25, child: SvgPicture.asset(iconPath)),
      label: Text(
        text,
        style: AppStyles.style13Regular.copyWith(color: AppColors.onBackground),
      ),
    );
  }
}
