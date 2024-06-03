import 'package:bgr_logistik/models/item_search_response.dart';
import 'package:bgr_logistik/models/order_request.dart';
import 'package:bgr_logistik/models/payment_method_response.dart';
import 'package:bgr_logistik/models/privileges_response.dart';

import '../../core_imports.dart';
import '../../models/order_response.dart';

class OrderDetailRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<ItemSearchResponse> getDetails({required List<int> ids}) async {
    try {
      final response = await _remoteDataSource
          .post(endpoint: '/items/details', body: {'itemIds': ids});

      return ItemSearchResponse.fromJson(response.data);
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
  
  Future<PrivilegesResponse> getPrivileges() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/privileges');

      return PrivilegesResponse.fromJson(response.data);
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
