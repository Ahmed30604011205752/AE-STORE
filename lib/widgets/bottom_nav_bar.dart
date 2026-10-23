import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, this.currentIndex = 0, this.onTap});

  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.brandNavy,
      unselectedItemColor: AppColors.brandDialBlue,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: _buildAnimatedIcon(
            icon: Icons.home_outlined,
            isSelected: currentIndex == 0,
          ),
          activeIcon: _buildAnimatedIcon(
            icon: Icons.home,
            isSelected: currentIndex == 0,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: _buildAnimatedIcon(
            icon: Icons.grid_view_outlined,
            isSelected: currentIndex == 1,
          ),
          activeIcon: _buildAnimatedIcon(
            icon: Icons.grid_view,
            isSelected: currentIndex == 1,
          ),
          label: "Categories",
        ),
        BottomNavigationBarItem(
          icon: _buildAnimatedIcon(
            icon: Icons.shopping_bag_outlined,
            isSelected: currentIndex == 2,
          ),
          activeIcon: _buildAnimatedIcon(
            icon: Icons.shopping_bag,
            isSelected: currentIndex == 2,
          ),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: _buildAnimatedIcon(
            icon: Icons.person_outline,
            isSelected: currentIndex == 3,
          ),
          activeIcon: _buildAnimatedIcon(
            icon: Icons.person,
            isSelected: currentIndex == 3,
          ),
          label: "Profile",
        ),
      ],
    );
  }

  Widget _buildAnimatedIcon({
    required IconData icon,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.brandNavy.withValues(alpha: 0.08) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AnimatedScale(
        scale: isSelected ? 1.15 : 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: Icon(icon),
      ),
    );
  }
}
