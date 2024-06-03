// To parse this JSON data, do
//
//     final paymentMethodResponse = paymentMethodResponseFromJson(jsonString);

import 'dart:convert';

PaymentMethodResponse paymentMethodResponseFromJson(String str) =>
    PaymentMethodResponse.fromJson(json.decode(str));

String paymentMethodResponseToJson(PaymentMethodResponse data) =>
    json.encode(data.toJson());

class PaymentMethodResponse {
  int code;
  bool success;
  List<PaymentMethodDatum> data;
  String message;

  PaymentMethodResponse({
    required this.code,
    required this.success,
    required this.data,
    required this.message,
  });

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      PaymentMethodResponse(
        code: json["code"],
        success: json["success"],
        data: List<PaymentMethodDatum>.from(json["data"].map((x) => PaymentMethodDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PaymentMethodDatum {
  int id;
  String method;
  dynamic createdAt;
  dynamic updatedAt;

  PaymentMethodDatum({
    required this.id,
    required this.method,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentMethodDatum.fromJson(Map<String, dynamic> json) => PaymentMethodDatum(
        id: json["id"],
        method: json["method"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method": method,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
