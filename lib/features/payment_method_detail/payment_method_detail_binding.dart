import 'package:bgr_logistik/core/repositories/payment_method_repository.dart';
import 'package:bgr_logistik/core_imports.dart';

import 'payment_method_detail_controller.dart';

class PaymentMethodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentMethodRepository());
    Get.lazyPut(() => PaymentMethodDetailController());
  }
}
