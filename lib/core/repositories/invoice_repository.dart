import 'package:bgr_logistik/models/invoice_response.dart';
import 'package:bgr_logistik/models/order_request.dart';
import 'package:bgr_logistik/models/payment_method_response.dart';

import '../../core_imports.dart';
import '../../models/order_response.dart';

class InvoiceRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<InvoiceResponse> getDetails({required int id}) async {
    try {
      final response = await _remoteDataSource
          .post(endpoint: '/orders', body: {'id': id});

      return InvoiceResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentMethodResponse> getPaymentMethod() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/paymentMethod');

      return PaymentMethodResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderResponse> createOrder({required OrderRequest request}) async {
    try {
      final response = await _remoteDataSource.post(
          endpoint: '/orders/insert', body: request);

      return OrderResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
