import 'dart:convert';

import 'customer.dart';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

class TransactionModel {
  TransactionModel({
    this.transactions,
  });

  List<Transaction>? transactions;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
      );
}

class Transaction {
  Transaction({
    this.id,
    this.customerId,
    this.amount,
    this.isSelected,
    this.createdAt,
    this.customer,
    this.chittyId,
    this.transactionNo,
  });

  int? id;
  int? customerId;
  int? amount;
  bool? isSelected;
  DateTime? createdAt;
  Customer? customer;
  int? chittyId;
  String? transactionNo;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        customerId: json["customer_id"],
        amount: json["amount"],
        isSelected: json["is_selected"] == 1 ? true : false,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        customer: Customer.fromJson(json["customer"]),
        chittyId: json["chitty_id"],
        transactionNo: json["transaction_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "amount": amount,
        "is_selected": isSelected == true ? 1 : 0,
        "chitty_id": chittyId,
      };

  String get amountString =>
      amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}
