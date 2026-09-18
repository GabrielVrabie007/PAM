import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_currency_converter/services/amount_parser.dart';

void main() {
  const parser = AmountParser();

  group('AmountParser', () {
    test('accepta un numar intreg', () {
      final parsed = parser.parse('100');

      expect(parsed.isValid, isTrue);
      expect(parsed.value, 100);
    });

    test('accepta punctul ca separator zecimal', () {
      expect(parser.parse('12.50').value, 12.5);
    });

    test('accepta virgula ca separator zecimal', () {
      expect(parser.parse('12,50').value, 12.5);
    });

    test('ignora spatiile din jur', () {
      expect(parser.parse('  42  ').value, 42);
    });

    test('respinge textul gol', () {
      final parsed = parser.parse('');

      expect(parsed.isValid, isFalse);
      expect(parsed.error, 'Introduceti o suma');
    });

    test('respinge un text care nu este numar', () {
      final parsed = parser.parse('abc');

      expect(parsed.isValid, isFalse);
      expect(parsed.error, 'Suma trebuie sa fie un numar');
    });

    test('respinge sumele negative', () {
      final parsed = parser.parse('-10');

      expect(parsed.isValid, isFalse);
      expect(parsed.error, 'Suma nu poate fi negativa');
    });
  });
}
