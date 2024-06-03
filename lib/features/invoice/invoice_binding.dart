import 'package:bgr_logistik/core/repositories/invoice_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/invoice/invoice_controller.dart';

class InvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvoiceRepository());
    Get.lazyPut(() => InvoiceController());
  }
}
