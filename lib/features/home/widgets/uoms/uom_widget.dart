import 'package:bgr_logistik/core_imports.dart';

import '../../../uom_detail/uom_detail_binding.dart';
import '../../../uom_detail/uom_detail_screen.dart';
import 'uom_controller.dart';

class UomWidget extends GetView<UomController> {
  const UomWidget({super.key});

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
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          final item = controller.items[index];

                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => const UomDetailScreen(),
                                binding: UomDetailBinding(),
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
                                    Utils.formatDate(
                                        pattern: 'dd MMMM yyyy',
                                        date: item.createdAt),
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
                        () => const UomDetailScreen(),
                        binding: UomDetailBinding(),
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
