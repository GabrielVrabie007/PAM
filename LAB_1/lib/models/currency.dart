class Currency {
  final String code;
  final String name;
  final String symbol;
  final double rateToBase;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rateToBase,
  });

  String get label => '$code - $name';

  @override
  bool operator ==(Object other) =>
      other is Currency && other.code == code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => code;
}
