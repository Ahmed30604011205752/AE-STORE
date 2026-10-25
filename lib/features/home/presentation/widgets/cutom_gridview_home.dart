import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/features/home/data/models/product_model.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_cubit.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_states.dart';
import 'package:ae_store/features/home/presentation/screens/product_screen.dart';
import 'package:ae_store/reviews/presentation/reviews_cubit/reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CutomGridviewHome extends StatelessWidget {
  const CutomGridviewHome({super.key, this.categoryId});

  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listenWhen: (previous, current) =>
          current is addToCartloding ||
          current is addToCartSuccess ||
          current is addToCartFailure,
      listener: (context, state) {
        final message = switch (state) {
          addToCartloding() => 'Adding item to your bag...',
          addToCartSuccess() => 'Added to your bag',
          addToCartFailure() => 'Could not add item to your bag',
          _ => null,
        };
        if (message == null) return;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: state is addToCartFailure
                  ? AppColors.error
                  : AppColors.primary,
            ),
          );
      },
      buildWhen: (previous, current) =>
          current is GetProductsLoadingState ||
          current is GetProductsSuccessState ||
          current is GetProductsFailureState ||
          current is SearchProductsLoadingState ||
          current is SearchProductsSuccessState ||
          current is SearchProductsFailureState ||
          current is ProductsInitialState,
      builder: (context, state) {
        final cubit = context.read<ProductsCubit>();
        final products = categoryId == null
            ? cubit.products
            : cubit.products
                  .where((product) => product.categoryIds.contains(categoryId))
                  .toList();

        if (cubit.isProductsLoading && products.isEmpty ||
            state is GetProductsLoadingState && products.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(36),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetProductsFailureState && products.isEmpty) {
          return _ProductsMessage(
            icon: Icons.wifi_off_outlined,
            message: state.error ?? 'Could not load products',
          );
        }

        if (products.isEmpty) {
          return _ProductsMessage(
            icon: Icons.search_off,
            message: categoryId == null
                ? 'No products available yet'
                : 'No products found in this category',
          );
        }

        return GridView.builder(
          key: ValueKey(categoryId),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 14,
            childAspectRatio: 0.5,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final categoryName = _categoryName(
              cubit.categories,
              product.categoryIds,
            );
            return _ProductCard(
              product: product,
              categoryName: categoryName,
              onTap: () => _openProduct(context, product),
              onAddToCart: () {
                if (product.id != null && product.id!.isNotEmpty) {
                  cubit.addToCart(product.id);
                }
              },
            );
          },
        );
      },
    );
  }

  String _categoryName(List categories, List<String> productCategoryIds) {
    for (final category in categories) {
      if (productCategoryIds.contains(category['id']?.toString())) {
        return category['name']?.toString() ?? 'Collection';
      }
    }
    if (productCategoryIds.isEmpty) return 'CURATED SELECTION';
    return productCategoryIds.first
        .replaceAll('-', ' ')
        .replaceAll('_', ' ')
        .toUpperCase();
  }

  void _openProduct(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ProductsCubit()),
            BlocProvider(create: (_) => ReviewCubit()),
          ],
          child: ProductDetails(product: product),
        ),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  const _ProductCard({
    required this.product,
    required this.categoryName,
    required this.onTap,
    required this.onAddToCart,
  });

  final ProductModel product;
  final String categoryName;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Material(
      color: AppColors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.network(
                        product.coverPictureUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.brandProductBackdrop,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            size: 36,
                            color: AppColors.brandDialBlue,
                          ),
                        ),
                      ),
                    ),
                    if (product.discountPercentage > 0)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryFixed,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                            style: AppStyles.style11Bold.copyWith(
                              color: AppColors.brandNavy,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Material(
                        color: AppColors.surfaceContainerLowest.withValues(
                          alpha: 0.94,
                        ),
                        shape: const CircleBorder(),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          tooltip: _isFavorite
                              ? 'Remove from favorites'
                              : 'Add to favorites',
                          onPressed: () {
                            setState(() => _isFavorite = !_isFavorite);
                          },
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite
                                ? AppColors.error
                                : AppColors.brandInk,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 9, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.categoryName.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.style11Bold.copyWith(
                          color: AppColors.brandTextMuted,
                          letterSpacing: 0.7,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.style14SemiBold.copyWith(
                          color: AppColors.brandInk,
                        ),
                      ),
                      if (product.reviewsCount > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 15,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: AppStyles.style12Medium.copyWith(
                                  color: AppColors.brandTextMuted,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '(${product.reviewsCount})',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.style12Regular.copyWith(
                                    color: AppColors.brandTextMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '\$${product.price.toStringAsFixed(0)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.style18ExtraBold.copyWith(
                                color: AppColors.brandInk,
                              ),
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            tooltip: 'Add to bag',
                            onPressed: widget.onAddToCart,
                            icon: const Icon(
                              Icons.add_shopping_cart_outlined,
                              color: AppColors.brandNavy,
                              size: 19,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductsMessage extends StatelessWidget {
  const _ProductsMessage({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 36, color: AppColors.brandTextMuted),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.style14Regular.copyWith(
                color: AppColors.brandTextMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
