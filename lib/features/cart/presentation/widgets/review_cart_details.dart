import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class ReviewCartDetails extends StatelessWidget {
  const ReviewCartDetails({
    super.key,
    required this.reviewerFirstLetter,
    required this.name,
    required this.date,
    required this.rating,
    required this.review,
  });
  final String reviewerFirstLetter;
  final String name;
  final String date;
  final double rating;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Text(reviewerFirstLetter)),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      date,
                      style: TextStyle(
                        color: AppColors.brandTextMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.star_border_rounded,
                  color: AppColors.primary,
                  size: 20,
                  fontWeight: FontWeight.w700,
                ),
                Text("$rating"),
              ],
            ),
            SizedBox(height: 8),
            Text(
              review,
              style: AppStyles.style13Regular.copyWith(
                color: AppColors.brandTextMuted,
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
