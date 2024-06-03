// To parse this JSON data, do
//
//     final invoiceResponse = invoiceResponseFromJson(jsonString);

import 'dart:convert';

InvoiceResponse invoiceResponseFromJson(String str) =>
    InvoiceResponse.fromJson(json.decode(str));

String invoiceResponseToJson(InvoiceResponse data) =>
    json.encode(data.toJson());

class InvoiceResponse {
  int code;
  bool success;
  InvoiceData data;
  String message;

  InvoiceResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceResponse(
        code: json["code"],
        success: json["success"],
        data: InvoiceData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class InvoiceData {
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
  String paymentMethod;
  int discountPercent;
  List<OrderLine> orderLines;

  InvoiceData({
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
    required this.paymentMethod,
    required this.discountPercent,
    required this.orderLines,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
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
        paymentMethod: json["paymentMethod"],
        discountPercent: json["discount_percent"],
        orderLines: List<OrderLine>.from(
            json["orderLines"].map((x) => OrderLine.fromJson(x))),
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
        "paymentMethod": paymentMethod,
        "discount_percent": discountPercent,
        "orderLines": List<dynamic>.from(orderLines.map((x) => x.toJson())),
      };
}

class OrderLine {
  int qty;
  String itemName;
  int itemPrice;
  String uom;

  OrderLine({
    required this.qty,
    required this.itemName,
    required this.itemPrice,
    required this.uom,
  });

  factory OrderLine.fromJson(Map<String, dynamic> json) => OrderLine(
        qty: json["qty"],
        itemName: json["itemName"],
        itemPrice: json["itemPrice"],
        uom: json["uom"],
      );

  Map<String, dynamic> toJson() => {
        "qty": qty,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "uom": uom,
      };
}
