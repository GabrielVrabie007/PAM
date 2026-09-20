import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Randul de stele verzi. Figma: 5 stele #508A7B.
class StarRating extends StatelessWidget {
  final int count;
  final double size;
  final double gap;

  const StarRating({
    super.key,
    this.count = 5,
    required this.size,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count,
        (i) => Padding(
          padding: EdgeInsets.only(right: i == count - 1 ? 0 : gap),
          child: Icon(Icons.star, size: size, color: AppColors.accent),
        ),
      ),
    );
  }
}
