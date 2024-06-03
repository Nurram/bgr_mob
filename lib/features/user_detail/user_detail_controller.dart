import 'package:bgr_logistik/core/repositories/user_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/user_request.dart';
import 'package:bgr_logistik/models/user_update_request.dart';
import 'package:bgr_logistik/models/users_response.dart';

import '../../core/repositories/role_repository.dart';
import '../../models/roles_response.dart';

class UserDetailController extends GetxController {
  final repo = Get.find<UsersRepository>();
  final roleRepo = Get.find<RoleRepository>();

  final key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  final isLoading = false.obs;
  final selectedRole = ''.obs;

  final Rx<UserDatum?> user = Rx(null);
  final roles = <RoleDatum>[].obs;

  @override
  void onInit() async {
    final args = Get.arguments;
    await fetchDatas();

    if (args != null) {
      user(UserDatum.fromJson(args.toJson()));

      nameCtr.text = user.value!.name;
      emailCtr.text = user.value!.email;

      final role =
          roles.firstWhere((element) => element.id == user.value!.roleId);
      selectedRole(role.name);
    }

    super.onInit();
  }

  fetchDatas() async {
    isLoading(true);

    try {
      final response = await roleRepo.getDatas();
      roles.clear();
      roles.addAll(response.data);
      selectedRole(roles.first.name);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.back();
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  editUser() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      final roleId =
          roles.firstWhere((element) => element.name == selectedRole.value).id;

      await repo.update(
        request: UserUpdateRequest(
            id: user.value!.id, name: nameCtr.text, roleId: roleId),
      );

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addUser() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      final roleId =
          roles.firstWhere((element) => element.name == selectedRole.value).id;

      await repo.insert(
        request: UsersRequest(
          name: nameCtr.text,
          email: emailCtr.text,
          password: passwordCtr.text,
          roleId: roleId,
        ),
      );

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  deleteUser() async {
    isLoading(true);

    try {
      await repo.delete(id: user.value!.id);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
