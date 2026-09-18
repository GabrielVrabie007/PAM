
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/currency_rates.dart';
import '../models/currency.dart';
import '../services/amount_parser.dart';
import '../services/currency_converter.dart';
import '../services/money_formatter.dart';
import '../widgets/conversion_result_card.dart';
import '../widgets/currency_dropdown.dart';



class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {

  final _parser = const AmountParser();
  final _converter = const CurrencyConverter();
  final _formatter = MoneyFormatter();

  final _amountController = TextEditingController();

  Currency _from = CurrencyRates.eur;
  Currency _to = CurrencyRates.mdl;

  String? _amountError;
  String? _result;
  String? _rateInfo;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _convert() {
    final parsed = _parser.parse(_amountController.text);

    if (!parsed.isValid) {
      setState(() {
        _amountError = parsed.error;
        _result = null;
        _rateInfo = null;
      });
      return;
    }

    final converted = _converter.convert(
      amount: parsed.value!,
      from: _from,
      to: _to,
    );
    final rate = _converter.exchangeRate(_from, _to);

    setState(() {
      _amountError = null;
      _result = _formatter.formatAmount(converted, _to);
      _rateInfo = _formatter.formatRate(rate, _from, _to);
    });
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _from;
      _from = _to;
      _to = temp;
    });

    if (_result != null) {
      _convert();
    }
  }

  void _onFromChanged(Currency currency) {
    setState(() => _from = currency);
  }

  void _onToChanged(Currency currency) {
    setState(() => _to = currency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversie moneda')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input: suma
              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Suma',
                  hintText: 'ex: 100',
                  border: const OutlineInputBorder(),
                  errorText: _amountError,
                ),
                onSubmitted: (_) => _convert(),
              ),
              const SizedBox(height: 20),

              CurrencyDropdown(
                label: 'Din',
                value: _from,
                currencies: CurrencyRates.all,
                onChanged: _onFromChanged,
              ),

              Align(
                child: IconButton(
                  onPressed: _swapCurrencies,
                  icon: const Icon(Icons.swap_vert),
                  tooltip: 'Inverseaza monedele',
                ),
              ),

              CurrencyDropdown(
                label: 'In',
                value: _to,
                currencies: CurrencyRates.all,
                onChanged: _onToChanged,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _convert,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Converteste'),
              ),
              const SizedBox(height: 24),

              if (_result != null)
                ConversionResultCard(result: _result!, rateInfo: _rateInfo),
            ],
          ),
        ),
      ),
    );
  }
}
