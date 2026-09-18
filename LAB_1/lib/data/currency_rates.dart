import '../models/currency.dart';

class CurrencyRates {
  const CurrencyRates._();

  static const Currency eur = Currency(
    code: 'EUR',
    name: 'Euro',
    symbol: '€',
    rateToBase: 1.0,
  );

  static const Currency usd = Currency(
    code: 'USD',
    name: 'Dolar american',
    symbol: r'$',
    rateToBase: 0.92,
  );

  static const Currency mdl = Currency(
    code: 'MDL',
    name: 'Leu moldovenesc',
    symbol: 'L',
    rateToBase: 0.052,
  );

  static const Currency ron = Currency(
    code: 'RON',
    name: 'Leu romanesc',
    symbol: 'lei',
    rateToBase: 0.20,
  );

  static const Currency gbp = Currency(
    code: 'GBP',
    name: 'Lira sterlina',
    symbol: '£',
    rateToBase: 1.17,
  );

  static const Currency uah = Currency(
    code: 'UAH',
    name: 'Grivna ucraineana',
    symbol: '₴',
    rateToBase: 0.022,
  );

  /// Lista folosita pentru popularea celor doua DropdownButton.
  static const List<Currency> all = [eur, usd, mdl, ron, gbp, uah];
}
