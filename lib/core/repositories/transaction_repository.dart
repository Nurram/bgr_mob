import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/orders_response.dart';

class TransactionRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<OrdersResponse> getDatas() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/orders');

      return OrdersResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
