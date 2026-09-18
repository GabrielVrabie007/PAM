import 'package:flutter/material.dart';

class ConversionResultCard extends StatelessWidget {
  final String result;
  final String? rateInfo;

  const ConversionResultCard({
    super.key,
    required this.result,
    this.rateInfo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rezultat', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(
              result,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            if (rateInfo != null) ...[
              const SizedBox(height: 8),
              Text(rateInfo!, style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
