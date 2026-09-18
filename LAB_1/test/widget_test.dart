import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_currency_converter/data/currency_rates.dart';
import 'package:lab1_currency_converter/main.dart';
import 'package:lab1_currency_converter/models/currency.dart';

void main() {
  group('ConverterScreen', () {
    testWidgets('afiseaza controalele cerute de tema', (tester) async {
      await tester.pumpWidget(const CurrencyConverterApp());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<Currency>), findsNWidgets(2));
      expect(find.widgetWithText(ElevatedButton, 'Converteste'), findsOneWidget);
    });

    testWidgets('converteste suma introdusa si afiseaza rezultatul', (
      tester,
    ) async {
      await tester.pumpWidget(const CurrencyConverterApp());

      // Implicit: EUR -> MDL, deci 100 EUR = 100 / 0.052 ≈ 1923.08 MDL
      await tester.enterText(find.byType(TextField), '100');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Converteste'));
      await tester.pumpAndSettle();

      expect(find.text('1,923.08 MDL'), findsOneWidget);
    });

    testWidgets('afiseaza eroare pentru input invalid', (tester) async {
      await tester.pumpWidget(const CurrencyConverterApp());

      await tester.tap(find.widgetWithText(ElevatedButton, 'Converteste'));
      await tester.pumpAndSettle();

      expect(find.text('Introduceti o suma'), findsOneWidget);
    });

    testWidgets('butonul de swap inverseaza monedele', (tester) async {
      await tester.pumpWidget(const CurrencyConverterApp());

      await tester.tap(find.byTooltip('Inverseaza monedele'));
      await tester.pumpAndSettle();

      final dropdowns = tester
          .widgetList<DropdownButtonFormField<Currency>>(
            find.byType(DropdownButtonFormField<Currency>),
          )
          .toList();

      expect(dropdowns[0].initialValue, CurrencyRates.mdl);
      expect(dropdowns[1].initialValue, CurrencyRates.eur);
    });
  });
}
