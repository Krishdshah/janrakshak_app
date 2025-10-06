// lib/presentation/widgets/custom_bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.cardBackground,
      surfaceTintColor: AppColors.cardBackground,
      shadowColor: Colors.black.withOpacity(0.1),
      elevation: 5,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, 'Dashboard', FontAwesomeIcons.house, context),
          _buildNavItem(1, 'Alerts', FontAwesomeIcons.bell, context),
          _buildNavItem(2, 'Predict', FontAwesomeIcons.chartLine, context),
          _buildNavItem(3, 'Reports', FontAwesomeIcons.clipboardList, context),
          _buildNavItem(4, 'Profile', FontAwesomeIcons.user, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon, BuildContext context) {
    final isSelected = index == currentIndex;

    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.primaryBlue : Colors.grey.shade600,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? AppColors.primaryBlue : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}