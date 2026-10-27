import 'dart:developer';

import 'package:ae_store/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/features/home/data/models/product_model.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_cubit.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_states.dart';
import 'package:ae_store/features/home/presentation/widgets/counter_button.dart';
import 'package:ae_store/features/home/presentation/widgets/description_section.dart';
import 'package:ae_store/features/home/presentation/widgets/product_info.dart';
import 'package:ae_store/features/home/presentation/widgets/product_options.dart';
import 'package:ae_store/features/home/presentation/widgets/reviews_section.dart';
import 'package:ae_store/reviews/presentation/reviews_cubit/reviews_cubit.dart';
import 'package:ae_store/reviews/presentation/reviews_cubit/reviews_states.dart';
import 'package:ae_store/reviews/presentation/widgets/write_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? selectedSize;
  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getReviews(
      productId: (widget.product.id ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is addToCartloding) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'loading.....',
                style: AppStyles.style13Regular.copyWith(
                  color: AppColors.brandDialDeepBlue,
                ),
              ),
              backgroundColor: AppColors.brandDialMark,
            ),
          );
        } else if (state is addToCartFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message ?? 'Could not add item to your cart.',
              ),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is addToCartSuccess) {
          BlocProvider.of<CartCubit>(context, listen: false).getcart();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Added to your cart'),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.brandProductBackdrop,
        appBar: AppBar(
          backgroundColor: AppColors.brandProductBackdrop,
          leadingWidth: 90,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: AppColors.brandDialSilver,
              side: BorderSide(color: AppColors.inversePrimary),
            ),
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: AppColors.inversePrimary,
                side: BorderSide(color: AppColors.brandDialSilver),
              ),
              icon: Icon(Icons.share_outlined),
            ),
            SizedBox(height: 16),
            IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: AppColors.inversePrimary,
                side: BorderSide(color: AppColors.brandDialSilver),
              ),
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Color(0xffB9785B),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ReviewCubit, ReviewState>(
                    builder: (context, state) {
                      return ProductInfo(
                        image: widget.product.coverPictureUrl,
                        brand: widget.product.name,
                        description: widget.product.description,
                        price: widget.product.price,
                        oldPrice: widget.product.price * 1.3,
                        rating: context.read<ReviewCubit>().averageRating,
                        reviews: context.read<ReviewCubit>().reviewsCount,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(color: AppColors.brandDialSilver, height: 4),
                  SizedBox(height: 20),
                  ProductOptions(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      CounterButton(),
                      SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            log("add to cart pressed ${widget.product.name}");
                            BlocProvider.of<ProductsCubit>(
                              context,
                            ).addToCart(widget.product.id);
                          },
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Add to Cart",
                                  style: AppStyles.style16Bold.copyWith(
                                    color: AppColors.brandButtonSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  //* Description Section
                  DescriptionSection(description: widget.product.description),
                  SizedBox(height: 20),
                  //* Reviews Section
                  BlocBuilder<ReviewCubit, ReviewState>(
                    builder: (context, state) {
                      if (state is ReviewLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      } else if (state is ReviewFailureState) {
                        return Center(
                          child: Text(
                            'Failed to load reviews',
                            style: AppStyles.style13Regular.copyWith(
                              color: AppColors.brandDialBlue,
                            ),
                          ),
                        );
                      } else if (context.read<ReviewCubit>().reviews.isEmpty) {
                        return Center(
                          child: Text(
                            'No reviews yet',
                            style: AppStyles.style13Regular.copyWith(
                              color: AppColors.brandDialBlue,
                            ),
                          ),
                        );
                      } else {
                        return ReviewsSection(
                          reviews: context.read<ReviewCubit>().reviews,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  WriteReview(
                    productId: widget.product.id ?? '',
                    onReviewAdded: () {
                      context.read<ReviewCubit>().getReviews(
                        productId: widget.product.id ?? '',
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
