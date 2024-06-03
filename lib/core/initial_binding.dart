import 'package:bgr_logistik/core/repositories/splash_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../features/splash/splash_controller.dart';
import 'network/remote_datasource.dart';
import 'repositories/auth_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => const FlutterSecureStorage(), fenix: true);

    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => RemoteDataSource(), fenix: true);
    Get.lazyPut(() => AuthRepository());

    Get.lazyPut(() => SplashRepository());
    Get.lazyPut(() => SplashController());
  }
}
