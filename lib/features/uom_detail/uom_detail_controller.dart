import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/uoms_response.dart';

import '../../core/repositories/uom_repository.dart';

class UomDetailController extends GetxController {
  final repo = Get.find<UomRepository>();

  final key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();

  final isLoading = false.obs;

  final Rx<UomDatum?> uom = Rx(null);

  @override
  void onInit() {
    final args = Get.arguments;

    if (args != null) {
      uom(args);
      nameCtr.text = uom.value!.name;
    }

    super.onInit();
  }

  editUom() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.update(id: uom.value!.id, name: nameCtr.text);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addUom() async {
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

  deleteUom() async {
    isLoading(true);

    try {
      await repo.delete(id: uom.value!.id);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
