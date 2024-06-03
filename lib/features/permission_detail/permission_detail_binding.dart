import 'package:bgr_logistik/core/repositories/permission_repository.dart';
import 'package:bgr_logistik/core_imports.dart';

import 'permission_detail_controller.dart';

class PermissionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PermissionRepository());
    Get.lazyPut(() => PermissionDetailController());
  }
}
