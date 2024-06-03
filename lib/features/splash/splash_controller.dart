import 'dart:convert';

import 'package:bgr_logistik/core/repositories/splash_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/home_binding.dart';
import 'package:bgr_logistik/features/home/home_screen.dart';
import 'package:bgr_logistik/features/login/login_screen.dart';
import 'package:bgr_logistik/models/role_permission_response.dart';

class SplashController extends GetxController {
  final repo = Get.find<SplashRepository>();

  final isLoading = false.obs;
  final permissions = <RolePermissionDatum>[].obs;

  @override
  void onInit() async {
    final token = await Utils.readFromSecureStorage(key: Constants.token);

    Future.delayed(const Duration(seconds: 2), () async {
      if (token != null) {
        try {
          await _getPermissions();
          Get.off(() => const HomeScreen(), binding: HomeBinding());
          // ignore: empty_catches
        } catch (e) {}
      } else {
        Get.off(() => const LoginScreen());
      }
    });

    super.onInit();
  }

  _getPermissions() async {
    isLoading(true);

    try {
      final user = Get.find<AuthController>().loggedInUser;
      final roleId = user.value!.roleId!;

      final response = await repo.getDatas(roleId: roleId);
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
