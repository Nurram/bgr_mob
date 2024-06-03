import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/user_detail/user_detail_binding.dart';
import 'package:bgr_logistik/features/user_detail/user_detail_screen.dart';

import 'users_controller.dart';

class UsersWidget extends GetView<UsersController> {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.fetchDatas(),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: controller.users.length,
                        itemBuilder: (context, index) {
                          final item = controller.users[index];

                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => const UserDetailScreen(),
                                binding: UserDetailBinding(),
                                arguments: item,
                              )?.then((value) {
                                if (value != null) controller.fetchDatas();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: StyleText.textBlack(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Role: ${item.roleName}',
                                    style: StyleText.textBlack(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  LoadingButton(
                    onPressed: () {
                      Get.to(
                        () => const UserDetailScreen(),
                        binding: UserDetailBinding(),
                      )?.then((value) {
                        if (value != null) controller.fetchDatas();
                      });
                    },
                    text: 'Tambah Data',
                    width: double.infinity,
                  ),
                ],
              ),
      ),
    );
  }
}
