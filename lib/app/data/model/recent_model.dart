// To parse this JSON data, do
//
//     final recentTransaction = recentTransactionFromJson(jsonString);

import 'dart:convert';

RecentTransaction recentTransactionFromJson(String str) => RecentTransaction.fromJson(json.decode(str));

class RecentTransaction {
  RecentTransaction({
    this.transactions,
  });

  List<Transactions>? transactions;

  factory RecentTransaction.fromJson(Map<String, dynamic> json) => RecentTransaction(
        transactions: List<Transactions>.from(json["transactions"].map((x) => Transactions.fromJson(x))),
      );
}

class Transactions {
  Transactions({
    this.amount,
    this.date,
    this.transactionNo,
    this.totalAmount,
  });

  int? amount;
  String? date;
  String? transactionNo;
  int? totalAmount;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        amount: json["amount"],
        date: json["date"],
        transactionNo: json["transaction_no"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "date": date,
        "transaction_no": transactionNo,
        "totalAmount": totalAmount,
      };
}
