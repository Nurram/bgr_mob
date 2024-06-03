// To parse this JSON data, do
//
//     final usersRequest = usersRequestFromJson(jsonString);

import 'dart:convert';

UsersRequest usersRequestFromJson(String str) =>
    UsersRequest.fromJson(json.decode(str));

String usersRequestToJson(UsersRequest data) => json.encode(data.toJson());

class UsersRequest {
  String name;
  String email;
  String password;
  int roleId;

  UsersRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.roleId,
  });

  factory UsersRequest.fromJson(Map<String, dynamic> json) => UsersRequest(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "roleId": roleId,
      };
}
