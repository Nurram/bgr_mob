import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/user_detail/user_detail_controller.dart';
import 'package:bgr_logistik/shared/widgets/confirmation_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class UserDetailScreen extends GetView<UserDetailController> {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () =>
              Text('${controller.user.value != null ? 'Edit' : 'Tambah'} User'),
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
              Obx(
                () => CustomTextFormField(
                  controller: controller.emailCtr,
                  hint: 'Email',
                  
                  readOnly: controller.user.value != null,
                ),
              ),
              Obx(
                () => controller.user.value != null
                    ? const SizedBox()
                    : CustomTextFormField(
                        controller: controller.passwordCtr,
                        hint: 'Password',
                      ),
              ),
              Obx(
                () => Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Pilih Role',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: controller.roles
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
                      value: controller.selectedRole.value,
                      onChanged: (String? value) {
                        controller.selectedRole(
                          value ?? controller.roles.first.name,
                        );
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
                  text: controller.user.value != null ? 'Edit' : 'Tambah',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.user.value != null
                        ? controller.editUser()
                        : controller.addUser();
                  },
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isLoading.value &&
                      controller.user.value != null,
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
        title: 'Hapus User',
        onConfirm: () {
          Get.back();
          controller.deleteUser();
        },
      ),
    );
  }
}
