import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// "Feature Products            Show all" - apare de 3 ori pe homepage.
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onShowAll;

  const SectionHeader({super.key, required this.title, this.onShowAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: AppTheme.sectionTitle),
        GestureDetector(
          onTap: onShowAll,
          child: Text('Show all', style: AppTheme.showAll),
        ),
      ],
    );
  }
}
