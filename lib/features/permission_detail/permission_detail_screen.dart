import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/shared/widgets/confirmation_dialog.dart';

import 'permission_detail_controller.dart';

class PermissionDetailScreen extends GetView<PermissionDetailController> {
  const PermissionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${controller.permission.value != null ? 'Edit' : 'Tambah'} Permission'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller.nameCtr,
                hint: 'Nama',
              ),
              const Spacer(),
              Obx(
                () => LoadingButton(
                  width: double.infinity,
                  text: controller.permission.value != null ? 'Edit' : 'Tambah',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.permission.value != null
                        ? controller.editUom()
                        : controller.addUom();
                  },
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isLoading.value &&
                      controller.permission.value != null,
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
        title: 'Hapus Permission',
        onConfirm: () {
          Get.back();
          controller.deleteUom();
        },
      ),
    );
  }
}
