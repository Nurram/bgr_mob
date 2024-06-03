import '../../core_imports.dart';

import '../../models/login/login_request.dart';
import '../../models/login/login_response.dart';
import '../constants/network_const.dart';

class AuthRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<LoginResponse> login({required LoginRequest request}) async {
    try {
      final response = await _remoteDataSource.post(
        endpoint: NetworkConst.login,
        body: request,
        noPop: true,
      );
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
