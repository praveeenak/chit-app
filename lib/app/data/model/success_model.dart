// To parse this JSON data, do
//
//     final successTransaction = successTransactionFromJson(jsonString);

import 'dart:convert';

SuccessTransaction successTransactionFromJson(String str) => SuccessTransaction.fromJson(json.decode(str));

class SuccessTransaction {
  SuccessTransaction({
    this.transactions,
  });

  RTransactions? transactions;

  factory SuccessTransaction.fromJson(Map<String, dynamic> json) => SuccessTransaction(
        transactions: RTransactions.fromJson(json["transactions"]),
      );
}

class RTransactions {
  RTransactions({
    this.id,
    this.customerId,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.transactionNo,
    this.customer,
  });

  int? id;
  int? customerId;
  int? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? transactionNo;
  Customers? customer;

  factory RTransactions.fromJson(Map<String, dynamic> json) => RTransactions(
        id: json["id"],
        customerId: json["customer_id"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        transactionNo: json["transaction_no"],
        customer: Customers.fromJson(json["customer"]),
      );
}

class Customers {
  Customers({
    this.name,
    this.phone,
    this.chittyNumber,
  });

  String? name;
  String? phone;
  String? chittyNumber;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
        name: json["name"],
        phone: json["phone"],
        chittyNumber: json["chitty_number"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
      };
}
