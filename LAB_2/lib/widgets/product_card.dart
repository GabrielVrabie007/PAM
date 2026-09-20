import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Cardul vertical din "Feature Products" si "Similar Product".
/// Figma: imagine 126x172 r=10 pe fundal #F4F2F0, nume + pret dedesubt.
class ProductCard extends StatelessWidget {
  static const double cardWidth = 126;
  static const double imageHeight = 172;

  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: cardWidth,
                height: imageHeight,
                color: AppColors.surfaceCard,
                child: Image.asset(product.image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              product.name,
              style: AppTheme.productName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(product.formattedPrice, style: AppTheme.productPrice),
          ],
        ),
      ),
    );
  }
}
