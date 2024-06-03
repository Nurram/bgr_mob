import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/role_detail/role_detail_controller.dart';
import 'package:bgr_logistik/shared/widgets/confirmation_dialog.dart';

class RoleDetailScreen extends GetView<RoleDetailController> {
  const RoleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () =>
              Text('${controller.role.value != null ? 'Edit' : 'Tambah'} Role'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.key,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: controller.nameCtr,
                hint: 'Nama',
              ),
              const SizedBox(height: 32),
              Text(
                'List Izin',
                style: StyleText.textBlack(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Obx(
                () => Column(
                  children: [
                    ...controller.permissions.map(
                      (e) => CheckboxListTile(
                        value: e.isActive == 1,
                        title: Text(e.name),
                        onChanged: (value) {
                          if (value != null) {
                            final index = controller.permissions.indexOf(e);
                            controller.permissions[index].isActive =
                                value ? 1 : 0;

                            controller.permissions.refresh();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Obx(
                () => LoadingButton(
                  width: double.infinity,
                  text: controller.role.value != null ? 'Edit' : 'Tambah',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.role.value != null
                        ? controller.editRole()
                        : controller.addRole();
                  },
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isLoading.value &&
                      controller.role.value != null,
                  child: TextButton(
                    onPressed: _showConfirmationDialog,
                    child: Text(
                      'Hapus',
                      style: StyleText.textRed(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showConfirmationDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => CustomConfirmationDialog(
        title: 'Hapus Role',
        onConfirm: () {
          Get.back();
          controller.deleteRole();
        },
      ),
    );
  }
}
