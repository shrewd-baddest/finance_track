class CurrencyConversion {
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double? convertedAmount;
  final double? rate;

  CurrencyConversion({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    this.rate,
    this.convertedAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'from_currency': fromCurrency,
      'to_currency': toCurrency,
      'amount': amount,
    };
  }

  factory CurrencyConversion.fromJson(Map<String, dynamic> json) {
    return CurrencyConversion(
      fromCurrency: json['from_currency'],
      toCurrency: json['to_currency'],
      amount: (json['from_amount'] as num).toDouble(),
      convertedAmount: (json['to_amount'] as num).toDouble(),
      rate: (json['rate_used'] as num).toDouble(),
    );
  }
}
