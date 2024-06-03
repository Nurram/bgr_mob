import 'package:bgr_logistik/core/repositories/item_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/items_response.dart';

class ItemController extends GetxController {
  final repo = Get.find<ItemRepository>();

  final isLoading = true.obs;
  final items = <ItemDatum>[].obs;

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
