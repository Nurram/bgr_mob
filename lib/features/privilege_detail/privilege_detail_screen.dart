import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/privilege_detail/privilege_detail_controller.dart';
import 'package:bgr_logistik/shared/widgets/confirmation_dialog.dart';

class PrivilegeDetailScreen extends GetView<PrivilegeDetailController> {
  const PrivilegeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${controller.privilege.value != null ? 'Edit' : 'Tambah'} Privilege'),
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
              CustomTextFormField(
                controller: controller.discountCtr,
                hint: 'Diskon',
                inputType: TextInputType.number,
                suffix: '%',
              ),
              const Spacer(),
              Obx(
                () => LoadingButton(
                  width: double.infinity,
                  text: controller.privilege.value != null ? 'Edit' : 'Tambah',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.privilege.value != null
                        ? controller.editUom()
                        : controller.addUom();
                  },
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isLoading.value &&
                      controller.privilege.value != null,
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
        title: 'Hapus Privilege',
        onConfirm: () {
          Get.back();
          controller.deleteUom();
        },
      ),
    );
  }
}
