// To parse this JSON data, do
//
//     final dueTransaction = dueTransactionFromJson(jsonString);

import 'dart:convert';

DueTransaction dueTransactionFromJson(String str) => DueTransaction.fromJson(json.decode(str));

class DueTransaction {
  DueTransaction({
    this.dueCustomers,
  });

  List<DueCustomer>? dueCustomers;

  factory DueTransaction.fromJson(Map<String, dynamic> json) => DueTransaction(
        dueCustomers: List<DueCustomer>.from(json["due_customers"].map((x) => DueCustomer.fromJson(x))),
      );
}

class DueCustomer {
  DueCustomer({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.cId,
  });

  int? id;
  String? name;
  String? phone;
  String? address;
  int? cId;

  factory DueCustomer.fromJson(Map<String, dynamic> json) => DueCustomer(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        cId: json["c_id"],
      );
}
