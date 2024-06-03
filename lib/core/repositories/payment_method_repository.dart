import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/payment_method_response.dart';

class PaymentMethodRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<PaymentMethodResponse> getDatas() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/paymentMethod');

      return PaymentMethodResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  insert({required String name}) async {
    try {
      await _remoteDataSource
          .post(endpoint: '/paymentMethod/insert', body: {'name': name});
    } catch (e) {
      rethrow;
    }
  }

  update({required int id, required String name}) async {
    try {
      await _remoteDataSource.post(endpoint: '/paymentMethod/update', body: {
        'id': id,
        'name': name,
      });
    } catch (e) {
      rethrow;
    }
  }

  delete({required int id}) async {
    try {
      await _remoteDataSource
          .delete(endpoint: '/paymentMethod/delete', body: {'id': id});
    } catch (e) {
      rethrow;
    }
  }
}
