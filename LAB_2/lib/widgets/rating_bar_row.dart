import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Un rand din histograma de reviews: "5 ★ [====----] 80%".
/// Figma: track 234x4 r=2 #EFF0F1, umplere #508A7B.
class RatingBarRow extends StatelessWidget {
  final int stars;
  final double fill;
  final String label;

  const RatingBarRow({
    super.key,
    required this.stars,
    required this.fill,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final numberStyle = AppTheme.font(
      size: 12,
      weight: FontWeight.w300,
      color: AppColors.textMuted,
      height: 16,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          SizedBox(width: 13, child: Text('$stars', style: numberStyle)),
          const Icon(Icons.star, size: 13, color: AppColors.accent),
          const SizedBox(width: 11),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: fill,
                minHeight: 4,
                backgroundColor: AppColors.ratingTrack,
                valueColor: const AlwaysStoppedAnimation(AppColors.accent),
              ),
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 30,
            child: Text(
              label,
              textAlign: TextAlign.right,
              style: numberStyle.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
