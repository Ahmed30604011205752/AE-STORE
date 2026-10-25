import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_cubit.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCategoriesHome extends StatelessWidget {
  const CustomCategoriesHome({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  final String? selectedCategoryId;
  final ValueChanged<String?> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) =>
          current is GetCategoriesLoadingState ||
          current is GetCategoriesSuccessState ||
          current is GetCategoriesFailureState ||
          current is GetProductsLoadingState ||
          current is GetProductsSuccessState ||
          current is GetProductsFailureState ||
          current is ProductsInitialState,
      builder: (context, state) {
        final cubit = context.read<ProductsCubit>();
        final categories = _getCategories(cubit);

        if (state is GetCategoriesFailureState &&
            categories.isEmpty &&
            cubit.products.isEmpty) {
          return SizedBox(
            height: 42,
            child: Center(
              child: Text(
                state.error ?? 'Unable to load categories',
                style: AppStyles.style12Medium.copyWith(
                  color: AppColors.brandTextMuted,
                ),
              ),
            ),
          );
        }

        return SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isAll = index == 0;
              final category = isAll ? null : categories[index - 1];
              final id = category?['id'];
              final name = isAll ? 'All' : category?['name'] ?? 'Category';
              final isSelected = isAll
                  ? selectedCategoryId == null
                  : id == selectedCategoryId;

              return ChoiceChip(
                label: Text(name),
                selected: isSelected,
                onSelected: (_) => onCategorySelected(id),
                showCheckmark: false,
                labelStyle: AppStyles.style13SemiBold.copyWith(
                  color: isSelected ? AppColors.onPrimary : AppColors.brandInk,
                ),
                selectedColor: AppColors.brandNavy,
                backgroundColor: AppColors.surfaceContainerLow,
                side: BorderSide.none,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              );
            },
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getCategories(ProductsCubit cubit) {
    final productCategoryIds = cubit.products
        .expand((product) => product.categoryIds)
        .toSet();
    final categoryList = <Map<String, String>>[];

    for (final categoryId in productCategoryIds) {
      Map? matchingCategory;
      for (final category in cubit.categories) {
        if (category is Map &&
            (category['slug']?.toString() == categoryId ||
                category['id']?.toString() == categoryId ||
                category['name']?.toString() == categoryId)) {
          matchingCategory = category;
          break;
        }
      }
      final label =
          matchingCategory?['name']?.toString() ?? _formatName(categoryId);

      categoryList.add({'id': categoryId, 'name': label});
    }

    if (categoryList.isEmpty) {
      for (final category in cubit.categories) {
        if (category is Map) {
          final id =
              category['slug']?.toString() ??
              category['id']?.toString() ??
              category['name']?.toString();
          final name = category['name']?.toString() ?? id;
          if (id != null && name != null) {
            categoryList.add({'id': id, 'name': name});
          }
        }
      }
    }

    return categoryList;
  }

  String _formatName(String value) {
    return value
        .replaceAll('-', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }
}
