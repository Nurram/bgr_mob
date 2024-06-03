import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/payment_method_detail/payment_method_detail_controller.dart';
import 'package:bgr_logistik/shared/widgets/confirmation_dialog.dart';

class PaymentMethodDetailScreen extends GetView<PaymentMethodDetailController> {
  const PaymentMethodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${controller.method.value != null ? 'Edit' : 'Tambah'} Metode Pembayaran'),
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
                  text: controller.method.value != null ? 'Edit' : 'Tambah',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.method.value != null
                        ? controller.editMethod()
                        : controller.addMethod();
                  },
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isLoading.value &&
                      controller.method.value != null,
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
        title: 'Hapus Metode Pembayaran',
        onConfirm: () {
          Get.back();
          controller.deleteMethod();
        },
      ),
    );
  }
}
