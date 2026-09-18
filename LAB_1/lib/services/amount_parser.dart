
class ParsedAmount {
  final double? value;
  final String? error;

  const ParsedAmount.valid(double this.value) : error = null;
  const ParsedAmount.invalid(String this.error) : value = null;

  bool get isValid => value != null;
}


class AmountParser {
  const AmountParser();

  ParsedAmount parse(String input) {
    final text = input.trim().replaceAll(',', '.');

    if (text.isEmpty) {
      return const ParsedAmount.invalid('Introduceti o suma');
    }

    final value = double.tryParse(text);
    if (value == null) {
      return const ParsedAmount.invalid('Suma trebuie sa fie un numar');
    }

    if (value < 0) {
      return const ParsedAmount.invalid('Suma nu poate fi negativa');
    }

    return ParsedAmount.valid(value);
  }
}
