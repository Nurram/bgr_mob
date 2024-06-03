import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/roles_response.dart';

import '../../models/role_permission_response.dart';

class RoleRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<RolesResponse> getDatas() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/roles');

      return RolesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  insert({required String name}) async {
    try {
      await _remoteDataSource
          .post(endpoint: '/roles/insert', body: {'name': name});
    } catch (e) {
      rethrow;
    }
  }

  update(
      {required int id,
      required String name,
      required List<RolePermissionDatum> permissions}) async {
    try {
      await _remoteDataSource.post(endpoint: '/roles/update', body: {
        'id': id,
        'name': name,
        'permissions': permissions,
      });
    } catch (e) {
      rethrow;
    }
  }

  delete({required int id}) async {
    try {
      await _remoteDataSource
          .delete(endpoint: '/roles/delete', body: {'id': id});
    } catch (e) {
      rethrow;
    }
  }

  Future<RolePermissionResponse> getPermissions({required int roleId}) async {
    try {
      final response = await _remoteDataSource.post(
        endpoint: '/rolePermissions/getByRoleId',
        body: {'roleId': roleId},
      );

      return RolePermissionResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
