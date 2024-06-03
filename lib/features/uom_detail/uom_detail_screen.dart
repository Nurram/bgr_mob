import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/shared/widgets/confirmation_dialog.dart';

import 'uom_detail_controller.dart';

class UomDetailScreen extends GetView<UomDetailController> {
  const UomDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text('${controller.uom.value != null ? 'Edit' : 'Tambah'} UOM'),
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
                  text: controller.uom.value != null ? 'Edit' : 'Tambah',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.uom.value != null
                        ? controller.editUom()
                        : controller.addUom();
                  },
                ),
              ),
              Obx(
                () => Visibility(
                  visible:
                      !controller.isLoading.value && controller.uom.value != null,
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
        title: 'Hapus UOM',
        onConfirm: () {
          Get.back();
          controller.deleteUom();
        },
      ),
    );
  }
}
