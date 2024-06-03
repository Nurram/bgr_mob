import 'dart:convert';

import 'package:bgr_logistik/core/repositories/auth_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/home_binding.dart';
import 'package:bgr_logistik/features/home/home_screen.dart';
import 'package:bgr_logistik/models/login/login_request.dart';

import '../../core/repositories/splash_repository.dart';
import '../../models/role_permission_response.dart';

class LoginController extends GetxController {
  final key = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  final splashRepo = Get.find<SplashRepository>();
  final repo = Get.find<AuthRepository>();

  final permissions = <RolePermissionDatum>[].obs;

  final isLoading = false.obs;

  login() async {
    if (!key.currentState!.validate()) {
      return;
    }

    try {
      isLoading(true);

      final request =
          LoginRequest(email: emailCtr.text, password: passwordCtr.text);
      final response = await repo.login(request: request);

      final authCtr = Get.find<AuthController>();
      authCtr.setCurrentLogedIn(
          userData: response.data!, token: response.token!);

      await _getPermissions();
      Get.offAll(() => const HomeScreen(), binding: HomeBinding());
      isLoading(false);
    } catch (e) {
      Utils.showGetSnackbar(e.toString(), false);
      isLoading(false);
    }
  }

  _getPermissions() async {
    isLoading(true);

    try {
      final user = Get.find<AuthController>().loggedInUser;
      final roleId = user.value!.roleId!;

      final response = await splashRepo.getDatas(roleId: roleId);
      permissions.clear();
      permissions.addAll(response.data);

      await Utils.storeToSecureStorage(
        key: 'permissions',
        data: jsonEncode(response.data),
      );

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
