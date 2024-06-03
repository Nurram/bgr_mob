import 'package:bgr_logistik/core/repositories/payment_method_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/payment_method_response.dart';

class PaymentMethodDetailController extends GetxController {
  final repo = Get.find<PaymentMethodRepository>();

  final key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();

  final isLoading = false.obs;

  final Rx<PaymentMethodDatum?> method = Rx(null);

  @override
  void onInit() {
    final args = Get.arguments;

    if (args != null) {
      method(args);
      nameCtr.text = method.value!.method;
    }

    super.onInit();
  }

  editMethod() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.update(id: method.value!.id, name: nameCtr.text);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addMethod() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.insert(name: nameCtr.text);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  deleteMethod() async {
    isLoading(true);

    try {
      await repo.delete(id: method.value!.id);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
