import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_styles.dart';
import 'package:ae_store/features/home/presentation/widgets/custom_container_row.dart';
import 'package:ae_store/features/home/presentation/widgets/cutom_gridview_home.dart';

import 'package:flutter/material.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key});

  @override
  State<CategoryProductsScreen> createState() => CategoryProductsScreenState();
}

class CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.background,
            side: BorderSide(color: AppColors.brandButtonMuted),
          ),
        ),
        centerTitle: true,
        title: Text('Category Products', style: AppStyles.style18ExtraBold),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Showing 24 products',
                      style: AppStyles.style13Regular.copyWith(
                        color: AppColors.brandTextMuted,
                      ),
                    ),
                    Spacer(),
                    SettingsContainer(
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
                              onPressed: () {},
                              icon: Icon(Icons.filter_list),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                CutomGridviewHome(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
