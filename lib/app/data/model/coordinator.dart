import 'dart:convert';

CoordinatorModel coordinatorModelFromJson(String str) => CoordinatorModel.fromJson(json.decode(str));

class CoordinatorModel {
  CoordinatorModel({
    this.coordinators,
  });

  List<Coordinator>? coordinators;

  factory CoordinatorModel.fromJson(Map<String, dynamic> json) => CoordinatorModel(
        coordinators: List<Coordinator>.from(json["coordinators"].map((x) => Coordinator.fromJson(x))),
      );
}

class Coordinator {
  Coordinator({
    this.id,
    this.name,
    this.phone,
  });

  int? id;
  String? name;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Coordinator.fromJson(Map<String, dynamic> json) => Coordinator(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
      };
}
