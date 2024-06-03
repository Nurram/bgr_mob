import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/permissions_response.dart';
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

  insert(
      {required String name,
      required List<RolePermissionDatum> permissions}) async {
    try {
      await _remoteDataSource.post(endpoint: '/roles/insert', body: {
        'name': name,
        'permissions': permissions,
      });
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

  Future<RolePermissionResponse> getPermissionsNew() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/permissions');

      final responsData = PermissionsResponse.fromJson(response.data);
      final responseDatums = <RolePermissionDatum>[];

      for (var element in responsData.data) {
        final responseDatum = RolePermissionDatum(
            id: element.id, name: element.name, isActive: 0);
        responseDatums.add(responseDatum);
      }

      return RolePermissionResponse(
        code: responsData.code,
        success: responsData.success,
        data: responseDatums,
        message: responsData.message,
      );
    } catch (e) {
      rethrow;
    }
  }
}
