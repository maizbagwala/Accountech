class ChargesModel {
  String chargeName;
  double amount;

  ChargesModel({required this.chargeName, required this.amount});

  String get formattedAmount {
    return '\$${amount.toStringAsFixed(2)}';
  }

  factory ChargesModel.fromJson(Map<String, dynamic> json) {
    return ChargesModel(
      chargeName: json['chargeName'],
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chargeName': chargeName,
      'amount': amount,
    };
  }
}
