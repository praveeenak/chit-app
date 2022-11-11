import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

class CustomerModel {
  CustomerModel({
    this.customers,
  });

  List<Customer>? customers;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        customers: List<Customer>.from(json["customers"].map((x) => Customer.fromJson(x))),
      );
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.cId,
    this.chittyNumber,
    this.createdAt,
  });

  int? id;
  String? name;
  String? phone;
  String? address;
  int? cId;
  String? chittyNumber;
  DateTime? createdAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        cId: json["c_id"],
        chittyNumber: json["chitty_number"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "c_id": cId,
        "chitty_number": chittyNumber,
      };
}
