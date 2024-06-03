// To parse this JSON data, do
//
//     final uomsResponse = uomsResponseFromJson(jsonString);

import 'dart:convert';

UomsResponse uomsResponseFromJson(String str) =>
    UomsResponse.fromJson(json.decode(str));

String uomsResponseToJson(UomsResponse data) => json.encode(data.toJson());

class UomsResponse {
  int code;
  bool success;
  List<UomDatum> data;
  String message;

  UomsResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory UomsResponse.fromJson(Map<String, dynamic> json) => UomsResponse(
        code: json["code"],
        success: json["success"],
        data: List<UomDatum>.from(json["data"].map((x) => UomDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class UomDatum {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  UomDatum({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UomDatum.fromJson(Map<String, dynamic> json) => UomDatum(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
