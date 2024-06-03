// To parse this JSON data, do
//
//     final usersRequest = usersRequestFromJson(jsonString);

import 'dart:convert';

UserUpdateRequest usersRequestFromJson(String str) =>
    UserUpdateRequest.fromJson(json.decode(str));

String usersRequestToJson(UserUpdateRequest data) => json.encode(data.toJson());

class UserUpdateRequest {
  int id;
  String name;
  int roleId;

  UserUpdateRequest({
    required this.id,
    required this.name,
    required this.roleId,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) => UserUpdateRequest(
        id: json["id"],
        name: json["name"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role_id": roleId,
      };
}
