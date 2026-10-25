import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/app_theme.dart';
import 'package:ae_store/core/widgets/search_text_field.dart';
import 'package:ae_store/features/home/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatefulWidget {
  const HomeScreenHeader({super.key, this.onTabChange});

  final ValueChanged<int>? onTabChange;

  @override
  State<HomeScreenHeader> createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                'AE',
                style: AppStyles.style14Bold.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '     Home   ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.style18ExtraBold.copyWith(color: colors.text),
              ),
            ),
            IconButton(
              tooltip: 'Notifications',
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined),
              color: colors.text,
            ),
            IconButton(
              tooltip: 'Cart',
              onPressed: () => widget.onTabChange?.call(2),
              icon: const Icon(Icons.shopping_bag_outlined),
              color: colors.text,
            ),
            IconButton(
              tooltip: 'Profile',
              onPressed: () => widget.onTabChange?.call(3),
              icon: const Icon(Icons.person_outline),
              color: colors.text,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SearchTextField(
          controller: _searchController,
          hintText: 'Search watches, fine jewelry, leather...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            tooltip: 'Search filters',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (_) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.tune),
          ),
        ),
      ],
    );
  }
}
