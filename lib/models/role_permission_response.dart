// To parse this JSON data, do
//
//     final rolePermissionResponse = rolePermissionResponseFromJson(jsonString);

import 'dart:convert';

RolePermissionResponse rolePermissionResponseFromJson(String str) =>
    RolePermissionResponse.fromJson(json.decode(str));

String rolePermissionResponseToJson(RolePermissionResponse data) =>
    json.encode(data.toJson());

class RolePermissionResponse {
  int code;
  bool success;
  List<RolePermissionDatum> data;
  String message;

  RolePermissionResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory RolePermissionResponse.fromJson(Map<String, dynamic> json) =>
      RolePermissionResponse(
        code: json["code"],
        success: json["success"],
        data: List<RolePermissionDatum>.from(
            json["data"].map((x) => RolePermissionDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class RolePermissionDatum {
  int id;
  String name;
  int isActive;

  RolePermissionDatum({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory RolePermissionDatum.fromJson(Map<String, dynamic> json) =>
      RolePermissionDatum(
        id: json["permissionId"],
        name: json["name"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "permissionId": id,
        "name": name,
        "is_active": isActive,
      };
}
