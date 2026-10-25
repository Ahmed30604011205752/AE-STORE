import 'package:ae_store/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:ae_store/features/cart/presentation/screens/cart_screen.dart';
import 'package:ae_store/features/home/presentation/screens/category_products_screen.dart';
import 'package:ae_store/features/home/presentation/screens/home_screen.dart';
import 'package:ae_store/features/profile/presentation/screens/profile_screen.dart';
import 'package:ae_store/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToTab(int index) {
    if (index < 0 || index >= 4 || index == currentIndex) return;

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutSine,
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen(onTabChange: _navigateToTab);
      case 1:
        return const CategoryProductsScreen();
      case 2:
        return BlocProvider(
          create: (_) => CartCubit(),
          child: const CartScreen(),
        );
      case 3:
        return const ProfileScreen();
      default:
        throw StateError('Unexpected bottom navigation index: $index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return _KeepAlivePage(child: _buildPage(index));
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: _navigateToTab,
      ),
    );
  }
}

class _KeepAlivePage extends StatefulWidget {
  const _KeepAlivePage({required this.child});

  final Widget child;

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
