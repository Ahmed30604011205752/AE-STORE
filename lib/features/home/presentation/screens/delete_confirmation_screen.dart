import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';

import 'package:flutter/material.dart';

class DeleteConfirmation extends StatelessWidget {
  const DeleteConfirmation({
    super.key,
    required this.onDelete,
    required this.productName,
  });

  final VoidCallback onDelete;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.brandButtonMuted),
        ),
        centerTitle: true,
        title: Text('DELETE ITEM', style: AppStyles.style18ExtraBold),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: AppColors.brandDialSilver,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.brandStrapBrown.withValues(
                          alpha: 0.15,
                        ),
                        shape: BoxShape.circle,
                      ),
                      height: 70,
                      width: 70,
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        size: 30,
                        color: AppColors.brandStrapBrown,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Delete $productName?',
                      textAlign: TextAlign.center,
                      style: AppStyles.style18ExtraBold,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Are you sure you want to permanently remove "$productName" from your inventory? This action cannot be undone.',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: AppStyles.style13Regular,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Cancel',
                            style: AppStyles.style14SemiBold,
                          ),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onDelete();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: AppColors.background,
                          ),
                          child: const Text(
                            'Delete',
                            style: AppStyles.style14SemiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
