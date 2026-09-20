import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Blocul de text din bannere: o liniuta verticala + eticheta mica,
/// apoi titlul pe mai multe randuri. Figma: gap 23 intre cele doua.
class BannerCaption extends StatelessWidget {
  final String label;
  final String title;
  final Color titleColor;
  final double titleSize;
  final double titleHeight;
  final FontWeight titleWeight;

  const BannerCaption({
    super.key,
    required this.label,
    required this.title,
    this.titleColor = AppColors.textBannerDark,
    this.titleSize = 20,
    this.titleHeight = 24,
    this.titleWeight = FontWeight.w300,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 1, height: 12, color: AppColors.textBanner),
            const SizedBox(height: 12, width: 9),
            Text(
              label,
              style: AppTheme.font(
                size: 12,
                weight: FontWeight.w300,
                color: AppColors.textBanner,
                height: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 23),
        Text(
          title,
          style: AppTheme.font(
            size: titleSize,
            weight: titleWeight,
            color: titleColor,
            height: titleHeight,
          ),
        ),
      ],
    );
  }
}
