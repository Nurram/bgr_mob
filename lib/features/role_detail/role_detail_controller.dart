import 'package:bgr_logistik/core/repositories/role_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/role_permission_response.dart';
import 'package:bgr_logistik/models/roles_response.dart';

class RoleDetailController extends GetxController {
  final repo = Get.find<RoleRepository>();

  final key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();

  final isLoading = false.obs;

  final Rx<RoleDatum?> role = Rx(null);
  final permissions = <RolePermissionDatum>[].obs;

  _getPermissions({required int id}) async {
    isLoading(true);

    try {
      final response = await repo.getPermissions(roleId: id);
      permissions.clear();
      permissions.addAll(response.data);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  _getPermissionsNew() async {
    isLoading(true);

    try {
      final response = await repo.getPermissionsNew();
      permissions.clear();
      permissions.addAll(response.data);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.back();
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() async {
    final args = Get.arguments;

    if (args != null) {
      role(args);
      nameCtr.text = role.value!.name;
      await _getPermissions(id: role.value!.id);
    } else {
      await _getPermissionsNew();
    }

    super.onInit();
  }

  editRole() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.update(
        id: role.value!.id,
        name: nameCtr.text,
        permissions: permissions,
      );

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addRole() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.insert(
        name: nameCtr.text,
        permissions: permissions,
      );

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  deleteRole() async {
    isLoading(true);

    try {
      await repo.delete(id: role.value!.id);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
