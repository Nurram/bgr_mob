import 'package:bgr_logistik/core/repositories/privileges_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/privileges_response.dart';

class PrivilegesController extends GetxController {
  final repo = Get.find<PrivilegeRepository>();

  final isLoading = true.obs;
  final privileges = <PrivilegeDatum>[].obs;

  fetchDatas() async {
    isLoading(true);

    try {
      final response = await repo.getDatas();
      privileges.clear();
      privileges.addAll(response.data);

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
