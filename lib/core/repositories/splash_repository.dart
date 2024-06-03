import 'package:bgr_logistik/core_imports.dart';

import '../../models/role_permission_response.dart';

class SplashRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<RolePermissionResponse> getDatas({required int roleId}) async {
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
