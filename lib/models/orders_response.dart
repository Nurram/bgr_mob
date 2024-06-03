// To parse this JSON data, do
//
//     final ordersResponse = ordersResponseFromJson(jsonString);

import 'dart:convert';

OrdersResponse ordersResponseFromJson(String str) =>
    OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse {
  int code;
  bool success;
  List<OrderDatum> data;
  String message;

  OrdersResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        code: json["code"],
        success: json["success"],
        data: List<OrderDatum>.from(json["data"].map((x) => OrderDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class OrderDatum {
  int id;
  int userId;
  String receiverName;
  String receiverAddress;
  String receiverPhone;
  String invoice;
  int paymentId;
  int privilegeId;
  int isPaid;
  int price;
  int priceAfterTax;
  DateTime createdAt;
  DateTime updatedAt;

  OrderDatum({
    required this.id,
    required this.userId,
    required this.receiverName,
    required this.receiverAddress,
    required this.receiverPhone,
    required this.invoice,
    required this.paymentId,
    required this.privilegeId,
    required this.isPaid,
    required this.price,
    required this.priceAfterTax,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
        id: json["id"],
        userId: json["user_id"],
        receiverName: json["receiver_name"],
        receiverAddress: json["receiver_address"],
        receiverPhone: json["receiver_phone"],
        invoice: json["invoice"],
        paymentId: json["payment_id"],
        privilegeId: json["privilege_id"],
        isPaid: json["isPaid"],
        price: json["price"],
        priceAfterTax: json["price_after_tax"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "receiver_name": receiverName,
        "receiver_address": receiverAddress,
        "receiver_phone": receiverPhone,
        "invoice": invoice,
        "payment_id": paymentId,
        "privilege_id": privilegeId,
        "isPaid": isPaid,
        "price": price,
        "price_after_tax": priceAfterTax,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
