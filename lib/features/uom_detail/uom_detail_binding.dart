import 'package:bgr_logistik/core/repositories/uom_repository.dart';
import 'package:bgr_logistik/core_imports.dart';

import 'uom_detail_controller.dart';

class UomDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UomRepository());
    Get.lazyPut(() => UomDetailController());
  }
}
