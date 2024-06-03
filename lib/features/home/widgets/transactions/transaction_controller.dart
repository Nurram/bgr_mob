import 'package:bgr_logistik/core/repositories/transaction_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/orders_response.dart';

class TransactionController extends GetxController {
  final repo = Get.find<TransactionRepository>();

  final transactions = <OrderDatum>[].obs;
  final isLoading = true.obs;

  fetchData() async {
    isLoading(true);

    try {
      final response = await repo.getDatas();
      transactions.clear();
      transactions.addAll(response.data);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
}
