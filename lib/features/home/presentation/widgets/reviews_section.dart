import 'dart:developer';

import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/features/cart/presentation/widgets/review_cart_details.dart';
import 'package:ae_store/features/home/data/models/reviews_model.dart';

import 'package:flutter/material.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key, required this.reviews});
  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text("Reviews (${reviews.length})", style: AppStyles.style16Bold),
              Spacer(),
              InkWell(
                onTap: () {
                  log("view All pressed");
                },
                child: Text(
                  "View all",
                  style: AppStyles.style13SemiBold.copyWith(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          for (var review in reviews)
            ReviewCartDetails(
              reviewerFirstLetter: review.userName[0],
              name: review.userName,
              date: review.date,
              rating: review.rating.toDouble(),
              review: review.comment,
            ),
        ],
      ),
    );
  }
}
