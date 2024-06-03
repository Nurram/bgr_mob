import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/privileges_response.dart';

class PrivilegeRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<PrivilegesResponse> getDatas() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/privileges');

      return PrivilegesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  insert({required String name, required int discount}) async {
    try {
      await _remoteDataSource.post(
        endpoint: '/privileges/insert',
        body: {'name': name, 'discountPercent': discount},
      );
    } catch (e) {
      rethrow;
    }
  }

  update({required int id, required String name, required int discount}) async {
    try {
      await _remoteDataSource.post(
        endpoint: '/privileges/update',
        body: {'id': id, 'name': name, 'discountPercent': discount},
      );
    } catch (e) {
      rethrow;
    }
  }

  delete({required int id}) async {
    try {
      await _remoteDataSource.delete(
        endpoint: '/privileges/delete',
        body: {'id': id},
      );
    } catch (e) {
      rethrow;
    }
  }
}
