// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  int code;
  bool success;
  OrderData data;
  String message;

  OrderResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        code: json["code"],
        success: json["success"],
        data: OrderData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class OrderData {
  int userId;
  String receiverName;
  String receiverAddress;
  String receiverPhone;
  int paymentId;
  int price;
  int priceAfterTax;
  int privilegeId;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String invoice;

  OrderData({
    required this.userId,
    required this.receiverName,
    required this.receiverAddress,
    required this.receiverPhone,
    required this.paymentId,
    required this.price,
    required this.priceAfterTax,
    required this.privilegeId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.invoice,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        userId: json["user_id"],
        receiverName: json["receiver_name"],
        receiverAddress: json["receiver_address"],
        receiverPhone: json["receiver_phone"],
        paymentId: json["payment_id"],
        price: json["price"],
        priceAfterTax: json["price_after_tax"],
        privilegeId: json["privilege_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        invoice: json["invoice"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "receiver_name": receiverName,
        "receiver_address": receiverAddress,
        "receiver_phone": receiverPhone,
        "payment_id": paymentId,
        "price": price,
        "price_after_tax": priceAfterTax,
        "privilege_id": privilegeId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "invoice": invoice,
      };
}
