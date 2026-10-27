import 'dart:developer';

import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/reviews/presentation/reviews_cubit/reviews_cubit.dart';
import 'package:ae_store/reviews/presentation/reviews_cubit/reviews_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({
    super.key,
    required this.productId,
    required this.onReviewAdded,
  });
  final String productId;
  final Function() onReviewAdded;

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final TextEditingController commentCTR = TextEditingController();
  @override
  void dispose() {
    commentCTR.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parentContext = context;
    return BlocListener<ReviewCubit, ReviewState>(
      listenWhen: (previous, current) {
        return current is AddReviewSuccessState ||
            current is AddReviewAlreadyReviewedState ||
            current is AddReviewFailureState;
      },
      listener: (listenerContext, state) {
        if (state is AddReviewSuccessState) {
          Navigator.pop(listenerContext);
          widget.onReviewAdded();
          ScaffoldMessenger.of(parentContext).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primary,
              content: const Text(
                "Thanks for sharing your feedback",
                style: AppStyles.style14Bold,
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is AddReviewAlreadyReviewedState) {
          ScaffoldMessenger.of(parentContext).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: const Text(
                "You can only review this product once",
                style: AppStyles.style14Bold,
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is AddReviewFailureState) {
          ScaffoldMessenger.of(parentContext).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(
                "Something went wrong. Please try again",
                style: AppStyles.style14Bold,
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(45),
          onTap: () {
            log("write a Review pressed");
            final reviewCubit = context.read<ReviewCubit>();
            //* Open Bottom Sheet for add new review
            showModalBottomSheet(
              context: context,
              builder: (context) {
                double selectedStars = 0;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        width: double.infinity,
                        height: 1000,
                        decoration: BoxDecoration(
                          color: AppColors.brandBadge,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: AppColors.brandDialSilver,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      "Write a Review",
                                      style: AppStyles.style20ExtraBold,
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.background,
                                        side: BorderSide(
                                          color: AppColors.brandDialMark,
                                          width: 1.2,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.close,
                                        size: 30,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Select Rating",
                                  style: AppStyles.style14Bold,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() => selectedStars = 1);
                                        },
                                        child: Icon(
                                          selectedStars >= 1
                                              ? Icons.star
                                              : Icons.star_border_rounded,
                                          color: selectedStars >= 1
                                              ? AppColors.primary
                                              : AppColors.brandButtonMuted,
                                          size: 40,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() => selectedStars = 2);
                                        },
                                        child: Icon(
                                          selectedStars >= 2
                                              ? Icons.star
                                              : Icons.star_border_rounded,
                                          color: selectedStars >= 2
                                              ? AppColors.primary
                                              : AppColors.background,
                                          size: 40,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() => selectedStars = 3);
                                        },
                                        child: Icon(
                                          selectedStars >= 3
                                              ? Icons.star
                                              : Icons.star_border_rounded,
                                          color: selectedStars >= 3
                                              ? AppColors.primary
                                              : AppColors.brandButtonMuted,
                                          size: 40,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() => selectedStars = 4);
                                        },
                                        child: Icon(
                                          selectedStars >= 4
                                              ? Icons.star
                                              : Icons.star_border_rounded,
                                          color: selectedStars >= 4
                                              ? AppColors.primary
                                              : AppColors.outlineVariant,
                                          size: 40,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() => selectedStars = 5);
                                        },
                                        child: Icon(
                                          selectedStars >= 5
                                              ? Icons.star
                                              : Icons.star_border_rounded,
                                          color: selectedStars >= 5
                                              ? AppColors.primary
                                              : AppColors.outlineVariant,
                                          size: 40,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "$selectedStars / 5.0",
                                        style: AppStyles.style14Bold.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Review Title",
                                  style: AppStyles.style14Bold,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor:
                                              AppColors.surfaceContainerLow,
                                          hintText: "Highly Recommended!",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: AppColors.outlineVariant,
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: AppColors.primary,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 18),
                                Text(
                                  "Review Description",
                                  style: AppStyles.style14Bold,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: commentCTR,
                                      maxLines: 5,
                                      minLines: 5,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            AppColors.surfaceContainerLow,
                                        hintText:
                                            "Don't forget to add your review description here...",
                                        hintMaxLines: 5,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColors.outlineVariant,
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColors.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(45),
                                    onTap: () async {
                                      if (selectedStars == 0) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text(
                                              "Please choose a rating first",
                                              style: AppStyles.style14Bold,
                                            ),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                        return;
                                      }
                                      if (commentCTR.text.trim().isEmpty) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text(
                                              "Please enter your review",
                                              style: AppStyles.style14Bold,
                                            ),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                        return;
                                      }
                                      await reviewCubit.addReview(
                                        productId: widget.productId,
                                        rating: selectedStars.toInt(),
                                        comment: commentCTR.text,
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        "Submit Review",
                                        style: AppStyles.style16Bold.copyWith(
                                          color: AppColors.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit_outlined,
                color: Color(0xff2D5143),
                size: 30,
              ),
              const SizedBox(width: 12),
              Text(
                "Write a Review",
                style: AppStyles.style14Bold.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
