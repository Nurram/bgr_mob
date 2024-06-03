// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  int code;
  bool success;
  List<UserDatum> data;
  String message;

  UsersResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        code: json["code"],
        success: json["success"],
        data: List<UserDatum>.from(json["data"].map((x) => UserDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class UserDatum {
  int id;
  String name;
  String email;
  int roleId;
  DateTime createdAt;
  DateTime updatedAt;
  String roleName;

  UserDatum({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.roleName,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roleId: json["role_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        roleName: json["roleName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role_id": roleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "roleName": roleName,
      };
}