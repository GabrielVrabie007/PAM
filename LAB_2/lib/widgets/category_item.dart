import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Iconita rotunda + eticheta din randul de categorii.
/// Cea activa are cerc inchis (#3A2C27) si un inel subtire in jur.
class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: active
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.categoryActive),
                  )
                : null,
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active
                    ? AppColors.categoryActive
                    : AppColors.surfaceCategoryOff,
              ),
              child: Icon(
                icon,
                size: 18,
                color: active ? Colors.white : AppColors.textCategoryOff,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTheme.font(
              size: 10,
              weight: FontWeight.w300,
              color: active ? AppColors.categoryActive : AppColors.textCategoryOff,
              height: 12,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
