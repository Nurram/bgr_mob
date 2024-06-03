import 'package:bgr_logistik/core/repositories/permission_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/permissions_response.dart';

class PermissionDetailController extends GetxController {
  final repo = Get.find<PermissionRepository>();

  final key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();

  final isLoading = false.obs;

  final Rx<PermissionDatum?> permission = Rx(null);

  @override
  void onInit() {
    final args = Get.arguments;

    if (args != null) {
      permission(args);
      nameCtr.text = permission.value!.name;
    }

    super.onInit();
  }

  editUom() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.update(id: permission.value!.id, name: nameCtr.text);

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
      await repo.delete(id: permission.value!.id);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
