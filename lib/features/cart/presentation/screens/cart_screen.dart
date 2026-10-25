import 'dart:developer';

import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/app_theme.dart';
import 'package:ae_store/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:ae_store/features/cart/presentation/cubits/cart_state.dart';
import 'package:ae_store/features/cart/presentation/screens/cart_empty_screen.dart';
import 'package:ae_store/features/home/presentation/widgets/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = true;
  List productsCart = [];

  double get calculateTotal {
    double total = 0;
    for (var item in productsCart) {
      total += item['basePricePerUnit'] * item['quantity'];
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).getcart();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('MY CART', style: AppStyles.style28ExtraBold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocConsumer<CartCubit, CartState>(
            listenWhen: (previous, current) {
              return current is removeCartfialure ||
                  current is removeCartsuccess;
            },
            listener: (context, state) {
              if (state is removeCartfialure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Could not update the cart.'),
                    backgroundColor: colorScheme.error,
                  ),
                );
              } else if (state is removeCartsuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('success.....'),
                    backgroundColor: colorScheme.primary,
                  ),
                );
              }
            },
            buildWhen: (previous, current) {
              return current is getcartloding ||
                  current is getcartempty ||
                  current is getcartfailure ||
                  current is getcartscusses;
            },
            builder: (context, state) {
              if (state is getcartloding) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is getcartempty) {
                return const CartEmptyScreen();
              } else if (state is getcartfailure) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 40),
                      const SizedBox(height: 12),
                      Text(state.error, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => context.read<CartCubit>().getcart(),
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                );
              } else if (state is getcartscusses) {
                productsCart = state.productscart;
                if (productsCart.isEmpty) {
                  return const CartEmptyScreen();
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productsCart.length,
                        itemBuilder: (context, index) {
                          final item = productsCart[index];
                          final String name =
                              item['productName'] ?? item['name'] ?? '';
                          final String imageUrl =
                              item['productCoverUrl'] ??
                              item['coverPictureUrl'] ??
                              '';
                          final String brand =
                              item['categoryName'] ??
                              item['brand'] ??
                              item['category'] ??
                              'MERIDIAN';
                          final String description =
                              item['description'] ??
                              item['productDescription'] ??
                              item['color'] ??
                              item['size'] ??
                              '';
                          final num rawPrice =
                              item['basePricePerUnit'] ?? item['price'] ?? 0;
                          final double price = rawPrice.toDouble();
                          final int quantity = (item['quantity'] is int)
                              ? item['quantity']
                              : int.tryParse(item['quantity'].toString()) ?? 1;

                          log('productsCart:${item['itemId']}');
                          return Dismissible(
                            key: ValueKey(
                              item['id'] ?? item['itemId'] ?? UniqueKey(),
                            ),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: colorScheme.error,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.delete_outline,
                                color: colorScheme.onError,
                                size: 28,
                              ),
                            ),
                            onDismissed: (direction) {
                              final itemId = item['itemId'] ?? item['id'];
                              if (itemId != null) {
                                BlocProvider.of<CartCubit>(
                                  context,
                                ).removeCart(itemId);
                              } else {
                                log('error');
                              }
                              setState(() {
                                productsCart.removeAt(index);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(14.0),
                              decoration: BoxDecoration(
                                color: colors.profileCard,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: colors.borderSide,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      width: 85,
                                      height: 85,
                                      color: colors.bottomBackground,
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              width: 85,
                                              height: 85,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Center(
                                                    child: Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      color: colors.gray,
                                                      size: 28,
                                                    ),
                                                  ),
                                            )
                                          : Center(
                                              child: Icon(
                                                Icons.image_outlined,
                                                color: colors.gray,
                                                size: 28,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          brand.toUpperCase(),
                                          style: AppStyles.style11Bold.copyWith(
                                            color: colors.gray,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          name,
                                          style: AppStyles.style17Bold.copyWith(
                                            color: colors.text,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (description.isNotEmpty) ...[
                                          const SizedBox(height: 3),
                                          Text(
                                            description,
                                            style: AppStyles.style13Regular
                                                .copyWith(color: colors.gray),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$${price.toStringAsFixed(2)}',
                                              style: AppStyles.style18ExtraBold
                                                  .copyWith(color: colors.text),
                                            ),
                                            CounterButton(
                                              initialValue: quantity,
                                              width: 110,
                                              height: 42,
                                              onChanged: (value) {
                                                setState(() {
                                                  item['quantity'] = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, size: 17, color: colors.gray),
                          SizedBox(width: 5),
                          Text(
                            'Swipe left to delete item',
                            style: AppStyles.style12Regular,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: colors.cardFill,
                                hintText: 'Enter promo code...',
                                hintStyle: AppStyles.style14Regular.copyWith(
                                  color: colors.gray,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(width: 0.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              log('is applied');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Apply',
                              style: AppStyles.style16Bold.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Card(
                        color: colors.cardFill,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Summary',
                                style: AppStyles.style14Bold,
                              ),
                              const SizedBox(height: 10),
                              CustomSummaryItem(
                                title: 'Subtotal',
                                value: '\$${calculateTotal.toStringAsFixed(2)}',
                              ),
                              const CustomSummaryItem(
                                title: 'Shipping',
                                value: 'free',
                              ),
                              Divider(color: colors.borderSide),
                              Row(
                                children: [
                                  Text('Total', style: AppStyles.style16Bold),
                                  const Spacer(),
                                  Text(
                                    '\$${calculateTotal.toStringAsFixed(2)}',
                                    style: AppStyles.style16Bold.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          log('you checkout ');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Proceed to Checkout',
                          style: AppStyles.style16Bold.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const CartEmptyScreen();
            },
          ),
        ),
      ),
    );
  }
}

class CustomSummaryItem extends StatelessWidget {
  const CustomSummaryItem({
    super.key,
    required this.title,
    required this.value,
  });
  final String title, value;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: AppStyles.style14Medium.copyWith(color: colors.gray),
          ),
          const Spacer(),
          Text(value, style: AppStyles.style14SemiBold),
        ],
      ),
    );
  }
}
