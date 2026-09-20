import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Cardul orizontal din "Recommended".
/// Figma: 213x66 - imagine 66x66 r=8 suprapusa peste un card alb 203x66 r=8.
class RecommendedCard extends StatelessWidget {
  static const double cardWidth = 213;
  static const double cardHeight = 66;

  final Product product;
  final VoidCallback? onTap;

  const RecommendedCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Stack(
          children: [
            // Cardul alb incepe la 10px de la stanga, ca imaginea sa iasa peste el.
            Positioned(
              left: 10,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.cardBorder),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: cardHeight,
                height: cardHeight,
                color: AppColors.surfaceRecImage,
                child: Image.asset(product.image, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              left: 75,
              top: 13,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
          ],
        ),
      ),
    );
  }
}
