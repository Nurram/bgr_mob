import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/widgets/items/item_controller.dart';
import 'package:bgr_logistik/features/item_detail/item_detail_binding.dart';
import 'package:bgr_logistik/features/item_detail/item_detail_screen.dart';

class ItemWIdget extends GetView<ItemController> {
  const ItemWIdget({super.key});

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
                                () => const ItemmDetailScreen(),
                                binding: ItemmDetailBinding(),
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          style: StyleText.textBlack(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Text(
                                        "IDR${Utils.numberFormat(item.price)}",
                                        style: StyleText.textPrimary(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Text(
                                        'SKU: ${item.sku}',
                                        style:
                                            StyleText.textBlack(fontSize: 12),
                                      ),
                                      const Spacer(),
                                      Text(
                                        Utils.formatDate(
                                            pattern: 'dd MMMM yyyy',
                                            date: item.createdAt),
                                        style:
                                            StyleText.textBlack(fontSize: 12),
                                      ),
                                    ],
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
                        () => const ItemmDetailScreen(),
                        binding: ItemmDetailBinding(),
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
