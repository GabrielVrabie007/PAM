import 'package:intl/intl.dart';

import '../models/currency.dart';

class MoneyFormatter {
  MoneyFormatter();

  final NumberFormat _amountFormat = NumberFormat('#,##0.00', 'en_US');
  final NumberFormat _rateFormat = NumberFormat('#,##0.0000', 'en_US');

  String formatAmount(double value, Currency currency) {
    return '${_amountFormat.format(value)} ${currency.code}';
  }

  String formatRate(double rate, Currency from, Currency to) {
    return '1 ${from.code} = ${_rateFormat.format(rate)} ${to.code}';
  }
}
