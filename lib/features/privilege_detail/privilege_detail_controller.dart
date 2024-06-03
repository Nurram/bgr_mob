import 'package:bgr_logistik/core/repositories/privileges_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/privileges_response.dart';

class PrivilegeDetailController extends GetxController {
  final repo = Get.find<PrivilegeRepository>();

  final key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final discountCtr = TextEditingController();

  final isLoading = false.obs;

  final Rx<PrivilegeDatum?> privilege = Rx(null);

  @override
  void onInit() {
    final args = Get.arguments;

    if (args != null) {
      privilege(args);
      nameCtr.text = privilege.value!.name;
      discountCtr.text = privilege.value!.discountPercent.toString();
    }

    super.onInit();
  }

  editUom() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.update(
        id: privilege.value!.id,
        name: nameCtr.text,
        discount: int.parse(discountCtr.text),
      );

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
      await repo.insert(
        name: nameCtr.text,
        discount: int.parse(discountCtr.text),
      );

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
      await repo.delete(id: privilege.value!.id);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
