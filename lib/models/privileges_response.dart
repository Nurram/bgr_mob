// To parse this JSON data, do
//
//     final privilegesResponse = privilegesResponseFromJson(jsonString);

import 'dart:convert';

PrivilegesResponse privilegesResponseFromJson(String str) =>
    PrivilegesResponse.fromJson(json.decode(str));

String privilegesResponseToJson(PrivilegesResponse data) =>
    json.encode(data.toJson());

class PrivilegesResponse {
  int code;
  bool success;
  List<PrivilegeDatum> data;
  String message;

  PrivilegesResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory PrivilegesResponse.fromJson(Map<String, dynamic> json) =>
      PrivilegesResponse(
        code: json["code"],
        success: json["success"],
        data: List<PrivilegeDatum>.from(json["data"].map((x) => PrivilegeDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PrivilegeDatum {
  int id;
  String name;
  int discountPercent;
  dynamic createdAt;
  dynamic updatedAt;

  PrivilegeDatum({
    required this.id,
    required this.name,
    required this.discountPercent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PrivilegeDatum.fromJson(Map<String, dynamic> json) => PrivilegeDatum(
        id: json["id"],
        name: json["name"],
        discountPercent: json["discount_percent"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "discount_percent": discountPercent,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
