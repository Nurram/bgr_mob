import 'package:bgr_logistik/core/repositories/user_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/users_response.dart';

class UsersController extends GetxController {
  final repo = Get.find<UsersRepository>();

  final isLoading = true.obs;
  final users = <UserDatum>[].obs;

  fetchDatas() async {
    isLoading(true);

    try {
      final response = await repo.getDatas();
      users.clear();
      users.addAll(response.data);

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
