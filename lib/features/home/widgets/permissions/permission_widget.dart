import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/permission_detail/permission_detail_binding.dart';
import 'package:bgr_logistik/features/permission_detail/permission_detail_screen.dart';

import 'permission_controller.dart';

class PermissionWidget extends GetView<PermissionController> {
  const PermissionWidget({super.key});

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
                        itemCount: controller.permissions.length,
                        itemBuilder: (context, index) {
                          final item = controller.permissions[index];

                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => const PermissionDetailScreen(),
                                binding: PermissionDetailBinding(),
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
                                    'Akses ${item.name}',
                                    style: StyleText.textBlack(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
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
                        () => const PermissionDetailScreen(),
                        binding: PermissionDetailBinding(),
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
