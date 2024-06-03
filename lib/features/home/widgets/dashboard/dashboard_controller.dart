import 'package:bgr_logistik/core/repositories/uom_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/uoms_response.dart';

class DashboardController extends GetxController {
  final repo = Get.find<UomRepository>();

  final salesDateCtr = TextEditingController();

  final isLoading = true.obs;
  final selectedChip = 'Penjualan'.obs;
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
    final startDate = DateFormat('dd/MM/yyyy').format(
      DateTime.now(),
    );
    final endDate = DateFormat('dd/MM/yyyy').format(
      DateTime.now(),
    );

    salesDateCtr.text = '$startDate - $endDate';
    fetchDatas();
    super.onInit();
  }
}
