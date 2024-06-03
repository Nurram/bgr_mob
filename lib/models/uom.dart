class Uom {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Uom({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Uom.fromJson(Map<String, dynamic> json) => Uom(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
