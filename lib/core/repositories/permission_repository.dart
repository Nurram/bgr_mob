import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/permissions_response.dart';

class PermissionRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<PermissionsResponse> getDatas() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/permissions');

      return PermissionsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  insert({required String name}) async {
    try {
      await _remoteDataSource
          .post(endpoint: '/permissions/insert', body: {'name': name});
    } catch (e) {
      rethrow;
    }
  }

  update({required int id, required String name}) async {
    try {
      await _remoteDataSource.post(endpoint: '/permissions/update', body: {
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
          .delete(endpoint: '/permissions/delete', body: {'id': id});
    } catch (e) {
      rethrow;
    }
  }
}
