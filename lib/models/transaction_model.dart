class TransactionModel {
  final String transaction_type;
  final double amount;
  final String description;
  final Map<String, dynamic> category;
  final String transaction_date;

  TransactionModel({
    required this.transaction_type,
    required this.amount,
    required this.category,
    required this.description,
    required this.transaction_date,
  });

  Map<String, dynamic> toJson() {
    return {
      "transaction_type": transaction_type,
      "amount": amount,
      "description": description,
      "category": category,
      "created_at": transaction_date,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: (json['amount'] as num).toDouble(),
      transaction_type: json['transaction_type'],
      description: json['description'],
      category: {'name': json['name'], 'icon': json['icon']},
      transaction_date: json['transaction_date'],
    );
  }
}
