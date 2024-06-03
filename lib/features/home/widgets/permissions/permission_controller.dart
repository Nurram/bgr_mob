import 'package:bgr_logistik/core/repositories/permission_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/permissions_response.dart';

class PermissionController extends GetxController {
  final repo = Get.find<PermissionRepository>();

  final isLoading = true.obs;
  final permissions = <PermissionDatum>[].obs;

  fetchDatas() async {
    isLoading(true);

    try {
      final response = await repo.getDatas();
      permissions.clear();
      permissions.addAll(response.data);

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
