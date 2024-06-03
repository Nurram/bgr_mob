// To parse this JSON data, do
//
//     final rolesResponse = rolesResponseFromJson(jsonString);

import 'dart:convert';

RolesResponse rolesResponseFromJson(String str) =>
    RolesResponse.fromJson(json.decode(str));

String rolesResponseToJson(RolesResponse data) => json.encode(data.toJson());

class RolesResponse {
  int code;
  bool success;
  List<RoleDatum> data;
  String message;

  RolesResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory RolesResponse.fromJson(Map<String, dynamic> json) => RolesResponse(
        code: json["code"],
        success: json["success"],
        data: List<RoleDatum>.from(json["data"].map((x) => RoleDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class RoleDatum {
  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;

  RoleDatum({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoleDatum.fromJson(Map<String, dynamic> json) => RoleDatum(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
