import 'package:bgr_logistik/core/repositories/order_detail_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/order_detail/order_detail_controller.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailRepository());
    Get.lazyPut(() => OrderDetailController());
  }
}
