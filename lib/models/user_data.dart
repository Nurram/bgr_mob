import 'role.dart';

class UserData {
  int? id;
  String? name;
  String? email;
  int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Role? role;

  UserData({
    this.id,
    this.name,
    this.email,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roleId: json["role_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role_id": roleId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role?.toJson(),
      };
}
