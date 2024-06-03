import 'package:bgr_logistik/core/repositories/dashboard_repository.dart';
import 'package:bgr_logistik/core/repositories/home_repository.dart';
import 'package:bgr_logistik/core/repositories/item_repository.dart';
import 'package:bgr_logistik/core/repositories/payment_method_repository.dart';
import 'package:bgr_logistik/core/repositories/permission_repository.dart';
import 'package:bgr_logistik/core/repositories/privileges_repository.dart';
import 'package:bgr_logistik/core/repositories/role_repository.dart';
import 'package:bgr_logistik/core/repositories/uom_repository.dart';
import 'package:bgr_logistik/core/repositories/user_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/home_controller.dart';
import 'package:bgr_logistik/features/home/widgets/dashboard/dashboard_controller.dart';
import 'package:bgr_logistik/features/home/widgets/items/item_controller.dart';
import 'package:bgr_logistik/features/home/widgets/payment_methods/payment_method_controller.dart';
import 'package:bgr_logistik/features/home/widgets/permissions/permission_controller.dart';
import 'package:bgr_logistik/features/home/widgets/privileges/privileges_controller.dart';
import 'package:bgr_logistik/features/home/widgets/roles/role_controller.dart';
import 'package:bgr_logistik/features/home/widgets/uoms/uom_controller.dart';
import 'package:bgr_logistik/features/home/widgets/users/users_controller.dart';

import '../../core/repositories/transaction_repository.dart';
import 'widgets/transactions/transaction_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardRepository(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);

    Get.lazyPut(() => HomeRepository(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);

    Get.lazyPut(() => TransactionRepository(), fenix: true);
    Get.lazyPut(() => TransactionController(), fenix: true);

    Get.lazyPut(() => UomRepository(), fenix: true);
    Get.lazyPut(() => UomController(), fenix: true);

    Get.lazyPut(() => ItemRepository(), fenix: true);
    Get.lazyPut(() => ItemController(), fenix: true);
    
    Get.lazyPut(() => PrivilegeRepository(), fenix: true);
    Get.lazyPut(() => PrivilegesController(), fenix: true);

    Get.lazyPut(() => PaymentMethodRepository(), fenix: true);
    Get.lazyPut(() => PaymentMethodController(), fenix: true);
    
    Get.lazyPut(() => RoleRepository(), fenix: true);
    Get.lazyPut(() => RoleController(), fenix: true);

    Get.lazyPut(() => PermissionRepository(), fenix: true);
    Get.lazyPut(() => PermissionController(), fenix: true);
    
    Get.lazyPut(() => UsersRepository(), fenix: true);
    Get.lazyPut(() => UsersController(), fenix: true);
  }

}