import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/user_request.dart';
import 'package:bgr_logistik/models/users_response.dart';

import '../../models/user_update_request.dart';

class UsersRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<UsersResponse> getDatas() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/users');

      return UsersResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  insert({required UsersRequest request}) async {
    try {
      await _remoteDataSource
          .post(endpoint: '/users/insert', body: request);
    } catch (e) {
      rethrow;
    }
  }

  update({required UserUpdateRequest request}) async {
    try {
      await _remoteDataSource.post(endpoint: '/users/update', body: request);
    } catch (e) {
      rethrow;
    }
  }

  delete({required int id}) async {
    try {
      await _remoteDataSource
          .delete(endpoint: '/users/delete', body: {'id': id});
    } catch (e) {
      rethrow;
    }
  }
}
