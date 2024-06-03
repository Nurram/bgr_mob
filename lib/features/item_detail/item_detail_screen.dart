import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/item_detail/item_detail_controller.dart';
import 'package:bgr_logistik/shared/widgets/confirmation_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ItemmDetailScreen extends GetView<ItemDetailController> {
  const ItemmDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () =>
              Text('${controller.item.value != null ? 'Edit' : 'Tambah'} Item'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: controller.nameCtr,
                hint: 'Nama',
              ),
              CustomTextFormField(
                controller: controller.skuCtr,
                hint: 'SKU',
                inputType: TextInputType.number,
              ),
              CustomTextFormField(
                controller: controller.priceCtr,
                hint: 'Harga',
                prefix: 'Rp',
                inputType: TextInputType.number,
              ),
              CustomTextFormField(
                controller: controller.stockCtr,
                hint: 'Stok',
                inputType: TextInputType.number,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Pilih Unit Of Material',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: controller.uoms
                          .map((item) => DropdownMenuItem<String>(
                                value: item.name,
                                child: Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: controller.selectedUom.value,
                      onChanged: (String? value) {
                        controller
                            .selectedUom(value ?? controller.uoms.first.name);
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Obx(
                () => LoadingButton(
                  width: double.infinity,
                  text: controller.item.value != null ? 'Edit' : 'Tambah',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.item.value != null
                        ? controller.editItem()
                        : controller.addItem();
                  },
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isLoading.value &&
                      controller.item.value != null,
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
        title: 'Hapus Item',
        onConfirm: () {
          Get.back();
          controller.deleteItem();
        },
      ),
    );
  }
}
