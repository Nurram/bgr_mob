import 'package:bgr_logistik/core/repositories/invoice_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/invoice_response.dart';
import 'package:flutter/services.dart';

class InvoiceController extends GetxController {
  final repo = Get.find<InvoiceRepository>();

  final isLoading = true.obs;
  final orderId = 0.obs;

  final Rx<InvoiceData?> invoice = Rx(null);

  @override
  void onInit() async {
    orderId(Get.arguments);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await getOrderDetail();
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    super.onClose();
  }

  getOrderDetail() async {
    isLoading(true);

    try {
      final response = await repo.getDetails(id: orderId.value);
      invoice(response.data);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.back();
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  int getItemPrice({required OrderLine data}) {
    return data.qty * data.itemPrice;
  }

  double calculateDiscout() {
    return invoice.value!.price * invoice.value!.discountPercent / 100;
  }

  double getPriceAfterDiscount() {
    int price = 0;

    for (var element in invoice.value!.orderLines) {
      price += getItemPrice(data: element);
    }

    return price - calculateDiscout();
  }

  double calculateTax() {
    final priceAfterDicount = invoice.value!.price - calculateDiscout();
    return priceAfterDicount * 11 / 100;
  }

  double getTotalPrice() {
    return invoice.value!.priceAfterTax.toDouble();
  }
}
