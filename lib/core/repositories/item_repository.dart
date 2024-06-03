import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/items_response.dart';

class ItemRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<ItemsResponse> getDatas() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/items');

      return ItemsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  insert({required Map<String, dynamic> body}) async {
    try {
      await _remoteDataSource.post(endpoint: '/items/insert', body: body);
    } catch (e) {
      rethrow;
    }
  }

  update({required Map<String, dynamic> body}) async {
    try {
      await _remoteDataSource.post(endpoint: '/items/update', body: body);
    } catch (e) {
      rethrow;
    }
  }

  delete({required int id}) async {
    try {
      await _remoteDataSource.delete(
        endpoint: '/items/delete',
        body: {'id': id},
      );
    } catch (e) {
      rethrow;
    }
  }
}
