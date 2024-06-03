import 'dart:convert';

import 'package:bgr_logistik/core/initial_binding.dart';
import 'package:bgr_logistik/features/login/login_screen.dart';

import '../core_imports.dart';
import '../models/user_data.dart';

class AuthController extends GetxController {
  final Rx<UserData?> loggedInUser = Rx(null);
  final token = ''.obs;

  getCurrentLoggedIn() async {
    final json = await Utils.readFromSecureStorage(key: Constants.userData);

    if (json != null) {
      final userData = UserData.fromJson(jsonDecode(json));
      loggedInUser(userData);
    }
  }

  setCurrentLogedIn({required UserData userData, required String token}) {
    loggedInUser(userData);
    this.token(token);

    final json = jsonEncode(userData.toJson());
    Utils.storeToSecureStorage(key: Constants.userData, data: json);
    Utils.storeToSecureStorage(key: Constants.token, data: token);
  }

  Future<bool> isLoggedIn() async {
    final json = await Utils.readFromSecureStorage(key: Constants.userData);
    return json != null && json.isNotEmpty;
  }

  Future<String?> getToken() async {
    final token = await Utils.readFromSecureStorage(key: Constants.token);
    this.token(token);

    return token;
  }

  logout() async {
    await Utils.clearSecureStorage();
    Get.offAll(() => const LoginScreen(), binding: InitialBinding());
  }

  @override
  void onInit() async {
    loggedInUser(await getCurrentLoggedIn());
    token(await getToken());
    super.onInit();
  }
}
