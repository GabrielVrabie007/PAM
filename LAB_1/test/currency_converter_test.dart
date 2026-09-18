import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_currency_converter/data/currency_rates.dart';
import 'package:lab1_currency_converter/services/currency_converter.dart';

void main() {
  const converter = CurrencyConverter();

  group('CurrencyConverter', () {
    test('aceeasi valuta returneaza suma neschimbata', () {
      final result = converter.convert(
        amount: 100,
        from: CurrencyRates.eur,
        to: CurrencyRates.eur,
      );

      expect(result, closeTo(100, 0.0001));
    });

    test('converteste din moneda de baza (EUR -> MDL)', () {
      // 1 EUR = 1 / 0.052 MDL ≈ 19.2308 MDL
      final result = converter.convert(
        amount: 1,
        from: CurrencyRates.eur,
        to: CurrencyRates.mdl,
      );

      expect(result, closeTo(19.2308, 0.001));
    });

    test('converteste intre doua valute non-baza (USD -> RON)', () {
      // 10 USD = 10 * 0.92 / 0.20 = 46 RON
      final result = converter.convert(
        amount: 10,
        from: CurrencyRates.usd,
        to: CurrencyRates.ron,
      );

      expect(result, closeTo(46, 0.0001));
    });

    test('conversia dus-intors returneaza suma initiala', () {
      final toUsd = converter.convert(
        amount: 250,
        from: CurrencyRates.mdl,
        to: CurrencyRates.usd,
      );
      final backToMdl = converter.convert(
        amount: toUsd,
        from: CurrencyRates.usd,
        to: CurrencyRates.mdl,
      );

      expect(backToMdl, closeTo(250, 0.0001));
    });

    test('suma zero ramane zero', () {
      final result = converter.convert(
        amount: 0,
        from: CurrencyRates.gbp,
        to: CurrencyRates.uah,
      );

      expect(result, 0);
    });

    test('suma negativa arunca ArgumentError', () {
      expect(
        () => converter.convert(
          amount: -5,
          from: CurrencyRates.eur,
          to: CurrencyRates.usd,
        ),
        throwsArgumentError,
      );
    });
  });

  group('exchangeRate', () {
    test('cursul invers este reciproca cursului direct', () {
      final direct = converter.exchangeRate(
        CurrencyRates.eur,
        CurrencyRates.usd,
      );
      final invers = converter.exchangeRate(
        CurrencyRates.usd,
        CurrencyRates.eur,
      );

      expect(direct * invers, closeTo(1, 0.0001));
    });

    test('cursul unei valute fata de ea insasi este 1', () {
      expect(
        converter.exchangeRate(CurrencyRates.ron, CurrencyRates.ron),
        closeTo(1, 0.0001),
      );
    });
  });
}
