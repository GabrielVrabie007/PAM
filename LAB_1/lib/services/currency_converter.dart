import '../models/currency.dart';


class CurrencyConverter {
  const CurrencyConverter();


  double exchangeRate(Currency from, Currency to) {
    return from.rateToBase / to.rateToBase;
  }

  double convert({
    required double amount,
    required Currency from,
    required Currency to,
  }) {
    if (amount < 0) {
      throw ArgumentError.value(amount, 'amount', 'Suma nu poate fi negativa');
    }
    return amount * exchangeRate(from, to);
  }
}
