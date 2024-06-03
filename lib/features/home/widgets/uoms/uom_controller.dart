import 'package:bgr_logistik/core/repositories/uom_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/uoms_response.dart';

class UomController extends GetxController {
  final repo = Get.find<UomRepository>();

  final isLoading = true.obs;
  final items = <UomDatum>[].obs;

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
