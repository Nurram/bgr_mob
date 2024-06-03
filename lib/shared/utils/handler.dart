import 'package:bgr_logistik/core/initial_binding.dart';
import 'package:bgr_logistik/features/login/login_screen.dart';

import '../../core_imports.dart';

handleUnauthorized() async {
  final authController = Get.find<AuthController>();
  authController.loggedInUser(null);

  await Utils.clearSecureStorage();
  await Get.offAll(() => const LoginScreen(), binding: InitialBinding());
}

handlerDioError({required DioException exception}) {
  if (exception.type == DioExceptionType.unknown) return '';

  final response = exception.response;
  final data = response?.data['message'];

  Utils.showGetSnackbar(data ?? '', false);
}
