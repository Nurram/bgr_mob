// To parse this JSON data, do
//
//     final permissionsResponse = permissionsResponseFromJson(jsonString);

import 'dart:convert';

PermissionsResponse permissionsResponseFromJson(String str) =>
    PermissionsResponse.fromJson(json.decode(str));

String permissionsResponseToJson(PermissionsResponse data) =>
    json.encode(data.toJson());

class PermissionsResponse {
  int code;
  bool success;
  List<PermissionDatum> data;
  String message;

  PermissionsResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory PermissionsResponse.fromJson(Map<String, dynamic> json) =>
      PermissionsResponse(
        code: json["code"],
        success: json["success"],
        data: List<PermissionDatum>.from(json["data"].map((x) => PermissionDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PermissionDatum {
  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;

  PermissionDatum({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PermissionDatum.fromJson(Map<String, dynamic> json) => PermissionDatum(
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
