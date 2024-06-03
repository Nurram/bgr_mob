import 'package:bgr_logistik/core/repositories/item_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/item_detail/item_detail_controller.dart';

class ItemmDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ItemRepository());
    Get.lazyPut(() => ItemDetailController());
  }
}
