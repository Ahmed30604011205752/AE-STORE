import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_cubit.dart';
import 'package:ae_store/features/home/presentation/widgets/custom_container_row.dart';
import 'package:ae_store/features/home/presentation/widgets/cutom_gridview_home.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key, this.categoryId, this.categoryName});

  final String? categoryId;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..getProducts(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          centerTitle: true,
          title: Text(
            categoryName ?? 'Category Products',
            style: AppStyles.style18ExtraBold,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        categoryName == null
                            ? 'Showing products'
                            : 'Showing products in $categoryName',
                        style: AppStyles.style13Regular.copyWith(
                          color: AppColors.brandButtonMuted,
                        ),
                      ),
                      const Spacer(),
                      const SettingsContainer(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 8),
                              Text(
                                'Sort & Filter',
                                style: AppStyles.style13Regular,
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                onPressed: null,
                                icon: Icon(Icons.filter_list),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CutomGridviewHome(categoryId: categoryId),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
