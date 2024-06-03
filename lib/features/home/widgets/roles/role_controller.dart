import 'package:bgr_logistik/core/repositories/role_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/roles_response.dart';

class RoleController extends GetxController {
  final repo = Get.find<RoleRepository>();

  final isLoading = true.obs;
  final items = <RoleDatum>[].obs;

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
