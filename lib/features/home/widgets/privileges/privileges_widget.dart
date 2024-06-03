import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/widgets/privileges/privileges_controller.dart';
import 'package:bgr_logistik/features/privilege_detail/privilege_detail_binding.dart';
import 'package:bgr_logistik/features/privilege_detail/privilege_detail_screen.dart';

class PrivilegesWidget extends GetView<PrivilegesController> {
  const PrivilegesWidget({super.key});

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
                        itemCount: controller.privileges.length,
                        itemBuilder: (context, index) {
                          final item = controller.privileges[index];

                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => const PrivilegeDetailScreen(),
                                binding: PrivilegeDetailBinding(),
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
                                    'Nama Unit: ${item.name}',
                                    style: StyleText.textBlack(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Diskon: ${item.discountPercent}%',
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
                        () => const PrivilegeDetailScreen(),
                        binding: PrivilegeDetailBinding(),
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
