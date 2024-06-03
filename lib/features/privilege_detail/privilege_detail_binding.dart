import 'package:bgr_logistik/core/repositories/privileges_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/privilege_detail/privilege_detail_controller.dart';

class PrivilegeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivilegeRepository());
    Get.lazyPut(() => PrivilegeDetailController());
  }
}
