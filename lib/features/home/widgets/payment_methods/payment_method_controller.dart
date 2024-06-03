import 'package:bgr_logistik/core/repositories/payment_method_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/payment_method_response.dart';

class PaymentMethodController extends GetxController {
  final repo = Get.find<PaymentMethodRepository>();

  final isLoading = true.obs;
  final items = <PaymentMethodDatum>[].obs;

  fetchDatas() async {
    isLoading(true);

    try {
      final response = await repo.getDatas();
      items.clear();
      items.addAll(response.data);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() {
    fetchDatas();
    super.onInit();
  }
}
