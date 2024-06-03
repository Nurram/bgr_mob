// To parse this JSON data, do
//
//     final itemSearchResponse = itemSearchResponseFromJson(jsonString);

import 'dart:convert';

ItemsResponse itemSearchResponseFromJson(String str) =>
    ItemsResponse.fromJson(json.decode(str));

String itemSearchResponseToJson(ItemsResponse data) =>
    json.encode(data.toJson());

class ItemsResponse {
  int code;
  bool success;
  List<ItemDatum> data;
  String message;

  ItemsResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory ItemsResponse.fromJson(Map<String, dynamic> json) =>
      ItemsResponse(
        code: json["code"],
        success: json["success"],
        data: List<ItemDatum>.from(
            json["data"].map((x) => ItemDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class ItemDatum {
  int id;
  int uomId;
  String name;
  int sku;
  int stock;
  int price;
  DateTime createdAt;
  DateTime updatedAt;

  ItemDatum({
    required this.id,
    required this.uomId,
    required this.name,
    required this.sku,
    required this.stock,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemDatum.fromJson(Map<String, dynamic> json) => ItemDatum(
        id: json["id"],
        uomId: json["uom_id"],
        name: json["name"],
        sku: json["sku"],
        stock: json["stock"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uom_id": uomId,
        "name": name,
        "sku": sku,
        "stock": stock,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Uom {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Uom({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Uom.fromJson(Map<String, dynamic> json) => Uom(
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
