import 'package:bgr_logistik/core/repositories/role_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/role_detail/role_detail_controller.dart';

class RoleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RoleRepository());
    Get.lazyPut(() => RoleDetailController());
  }
}
