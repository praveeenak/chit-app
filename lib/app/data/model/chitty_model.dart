// To parse this JSON data, do
//
//     final chittyModel = chittyModelFromJson(jsonString);

import 'dart:convert';

ChittyModel chittyModelFromJson(String str) => ChittyModel.fromJson(json.decode(str));

class ChittyModel {
  ChittyModel({
    this.chitties,
  });

  List<Chitty>? chitties;

  factory ChittyModel.fromJson(Map<String, dynamic> json) => ChittyModel(
        chitties: List<Chitty>.from(json["chitties"].map((x) => Chitty.fromJson(x))),
      );
}

class Chitty {
  Chitty({
    this.id,
    this.chittyName,
  });

  int? id;
  String? chittyName;

  factory Chitty.fromJson(Map<String, dynamic> json) => Chitty(
        id: json["id"],
        chittyName: json["chitty_name"],
      );
}
