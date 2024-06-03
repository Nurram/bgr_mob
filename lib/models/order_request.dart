// To parse this JSON data, do
//
//     final orderRequest = orderRequestFromJson(jsonString);

import 'dart:convert';

OrderRequest orderRequestFromJson(String str) =>
    OrderRequest.fromJson(json.decode(str));

String orderRequestToJson(OrderRequest data) => json.encode(data.toJson());

class OrderRequest {
  int userId;
  String receiverName;
  String receiverAddress;
  String receiverPhone;
  int paymentId;
  double price;
  double priceAfterTax;
  int privilegeId;
  List<OrderItem> items;

  OrderRequest({
    required this.userId,
    required this.receiverName,
    required this.receiverAddress,
    required this.receiverPhone,
    required this.paymentId,
    required this.price,
    required this.priceAfterTax,
    required this.privilegeId,
    required this.items,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        userId: json["userId"],
        receiverName: json["receiverName"],
        receiverAddress: json["receiverAddress"],
        receiverPhone: json["receiverPhone"],
        paymentId: json["paymentId"],
        price: json["price"],
        priceAfterTax: json["priceAfterTax"],
        privilegeId: json["privilegeId"],
        items: List<OrderItem>.from(json["items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "receiverName": receiverName,
        "receiverAddress": receiverAddress,
        "receiverPhone": receiverPhone,
        "paymentId": paymentId,
        "price": price,
        "priceAfterTax": priceAfterTax,
        "privilegeId": privilegeId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class OrderItem {
  int id;
  int qty;

  OrderItem({
    required this.id,
    required this.qty,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qty": qty,
      };
}
