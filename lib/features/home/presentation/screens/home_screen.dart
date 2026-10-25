import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_cubit.dart';
import 'package:ae_store/features/home/presentation/widgets/custom_categories_home.dart';
import 'package:ae_store/features/home/presentation/widgets/cutom_gridview_home.dart';
import 'package:ae_store/features/home/presentation/widgets/home_screen_header.dart';
import 'package:ae_store/features/home/presentation/widgets/offers_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onTabChange});

  final ValueChanged<int>? onTabChange;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductsCubit _productsCubit;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _productsKey = GlobalKey();
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _productsCubit = ProductsCubit()
      ..getCategories()
      ..getProducts()
      ..getOffers();
  }

  @override
  void dispose() {
    _productsCubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _showAllProducts() {
    final productsContext = _productsKey.currentContext;
    if (productsContext == null) return;

    Scrollable.ensureVisible(
      productsContext,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productsCubit,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeScreenHeader(onTabChange: widget.onTabChange),
                const SizedBox(height: 20),
                OffersSection(onExplore: _showAllProducts),
                const SizedBox(height: 20),
                CustomCategoriesHome(
                  selectedCategoryId: _selectedCategoryId,
                  onCategorySelected: (categoryId) {
                    setState(() => _selectedCategoryId = categoryId);
                  },
                ),
                const SizedBox(height: 26),
                Text(
                  'CURATED SELECTION',
                  style: AppStyles.style12Medium.copyWith(
                    color: AppColors.brandTextMuted,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Featured Creations',
                        style: AppStyles.style22Bold.copyWith(
                          color: AppColors.brandInk,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _selectedCategoryId = null);
                        _showAllProducts();
                      },
                      child: Text(
                        'View All ›',
                        style: AppStyles.style13SemiBold.copyWith(
                          color: AppColors.brandNavy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  key: _productsKey,
                  child: CutomGridviewHome(categoryId: _selectedCategoryId),
                ),
                const SizedBox(height: 24),
                const _ConciergeCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConciergeCard extends StatelessWidget {
  const _ConciergeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryFixed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppColors.brandNavy,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.support_agent, color: AppColors.onPrimary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRIVILEGED SERVICE',
                  style: AppStyles.style11Bold.copyWith(
                    color: AppColors.brandNavy,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Atelier Concierge',
                  style: AppStyles.style16Bold.copyWith(
                    color: AppColors.brandInk,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'One-on-one private styling & bespoke care',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.style12Regular.copyWith(
                    color: AppColors.brandTextMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.calendar_month_outlined, color: AppColors.brandNavy),
        ],
      ),
    );
  }
}
