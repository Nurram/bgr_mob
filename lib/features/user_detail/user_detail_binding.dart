import 'package:bgr_logistik/core/repositories/user_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/user_detail/user_detail_controller.dart';

class UserDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersRepository());
    Get.lazyPut(() => UserDetailController());
  }
}
