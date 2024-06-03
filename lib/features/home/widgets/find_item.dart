import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/home_controller.dart';
import 'package:bgr_logistik/features/order_detail/order_detail_binding.dart';
import 'package:bgr_logistik/features/order_detail/order_detail_screen.dart';
import 'package:bgr_logistik/models/item_search_response.dart';

class FindItemWidget extends GetView<HomeController> {
  const FindItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustomTextFormField(
            controller: controller.searchCtr,
            hint: 'Cari disini',
            suffixIcon: InkWell(
              onTap: () {
                controller.searchItem();
              },
              child: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        final item = controller.items[index];

                        return InkWell(
                          onTap: item.stock == 0
                              ? null
                              : () {
                                  _showBottomSheet(datum: item);
                                },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color:
                                  item.stock == 0 ? Colors.grey : Colors.white,
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
                                    Row(
                                      children: [
                                        Text(
                                          "IDR${Utils.numberFormat(item.price)}",
                                          style: StyleText.textPrimary(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '/${item.uom.name}',
                                          style:
                                              StyleText.textGrey(fontSize: 10),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text(
                                      'SKU: ${item.sku}',
                                      style: StyleText.textBlack(fontSize: 12),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Stok: ${item.stock}',
                                      style: StyleText.textBlack(fontSize: 12),
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
          Obx(
            () => Visibility(
              visible: controller.carts.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Get.to(
                      () => const OrderDetailScreen(),
                      binding: OrderDetailBinding(),
                      arguments: controller.carts,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        '${controller.carts.length} item dikeranjang',
                        style: StyleText.textWhite(),
                      ),
                      const Spacer(),
                      Text(
                        'IDR${Utils.numberFormat(controller.calculateCartPrice())}',
                        style: StyleText.textWhite(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _showBottomSheet({required ItemDatum datum}) {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                datum.name,
                style: StyleText.textBlack(fontWeight: FontWeight.w600),
              ),
              Text(
                'Stok: ${datum.stock}',
                style: StyleText.textBlack(fontSize: 12),
              ),
              const Divider(),
              Row(
                children: [
                  const Text('Masukan Jumlah:'),
                  const Spacer(),
                  IconButton(
                    onPressed: controller.reduceQty,
                    icon: const Icon(
                      Icons.remove,
                      size: 12,
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.qty.string,
                      style: StyleText.textBlack(),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.addQty,
                    icon: const Icon(
                      Icons.add,
                      size: 12,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total:',
                      style: StyleText.textBlack(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Obx(
                    () => Text(
                      "IDR${Utils.numberFormat(datum.price * controller.qty.value)}",
                      style: StyleText.textPrimary(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),
              LoadingButton(
                width: double.infinity,
                text: 'Masukan keranjang',
                onPressed: () {
                  controller.addToCart(item: datum);
                  Get.back();
                },
                isLoading: false,
              )
            ],
          ),
        );
      },
    ).then((value) {
      Future.delayed(const Duration(seconds: 1), () {
        controller.qty(1);
      });
    });
  }
}
