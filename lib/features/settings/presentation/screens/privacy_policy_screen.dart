import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_styles.dart';

import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Widget buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.style16Bold.copyWith(
            fontFamily: "Manrope",
            color: AppColors.brandDialBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: AppStyles.style14Regular.copyWith(
            color: AppColors.brandTextMuted,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 25,
            color: AppColors.brandDialBlue,
          ),
        ),
        title: Text("PRIVACY POLICY", style: AppStyles.style20ExtraBold),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "LAST UPDATED: OCTOBER 2026",
                style: AppStyles.style12Medium.copyWith(
                  fontFamily: "Manrope",
                  color: AppColors.brandTextMuted,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "At AE Store, your trust matters. This policy describes how we collect, safeguard, and handle your personal information to provide a secure shopping experience.",
                style: AppStyles.style14Regular.copyWith(
                  fontFamily: "Manrope",
                  color: AppColors.brandTextMuted,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: AppColors.brandTextMuted.withValues(alpha: 0.6)),
              const SizedBox(height: 16),

              buildSection(
                title: "1. Data Collection",
                content:
                    "We collect information you provide directly to us when registering for an account, updating your profile, placing an order, subscribing to our curated catalog, or communicating with us. This includes your name, email address, mailing address, and payment information processed through secure token channels.",
              ),
              const SizedBox(height: 20),

              buildSection(
                title: "2. How We Use Your Data",
                content:
                    "AE Store uses your data to personalize browsing, fulfill orders, provide delivery updates, and improve the shopping experience.",
              ),
              const SizedBox(height: 20),

              buildSection(
                title: "3. Third Party Sharing",
                content:
                    "We never sell, rent, or trade your personal information. We share only the information needed with delivery and payment providers to complete your orders.",
              ),
              const SizedBox(height: 20),

              buildSection(
                title: "4. Your Rights",
                content:
                    "You retain full control over your private records. You may access, adjust, or completely delete your personal details at any time through our interactive settings panel. If you wish to revoke email circular permission, you may click unsubscribe at the bottom of any luxury bulletin.",
              ),
              const SizedBox(height: 20),

              buildSection(
                title: "5. Contact Us",
                content:
                    "For questions about this policy or your personal data, contact us through the Contact Us screen in the app.",
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
