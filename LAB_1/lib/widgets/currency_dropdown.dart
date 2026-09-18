import 'package:flutter/material.dart';

import '../models/currency.dart';


class CurrencyDropdown extends StatelessWidget {
  final String label;
  final Currency value;
  final List<Currency> currencies;
  final ValueChanged<Currency> onChanged;

  const CurrencyDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 4),
        DropdownButtonFormField<Currency>(
          initialValue: value,
          isExpanded: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: currencies
              .map(
                (currency) => DropdownMenuItem<Currency>(
                  value: currency,
                  child: Text(currency.label),
                ),
              )
              .toList(),
          onChanged: (selected) {
            if (selected != null) {
              onChanged(selected);
            }
          },
        ),
      ],
    );
  }
}
