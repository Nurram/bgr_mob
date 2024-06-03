import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/invoice/invoice_binding.dart';
import 'package:bgr_logistik/features/order_detail/order_detail_controller.dart';
import 'package:bgr_logistik/features/order_detail/receiver_screen.dart';
import 'package:bgr_logistik/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../invoice/invoice_screen.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  const CustomDivider(),
                  _buildReceiver(),
                  const CustomDivider(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.fetchDatas(),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final cart = controller.carts[index];

                            return Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              cart.item.name,
                                              style: StyleText.textBlack(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Spacer(),
                                            Text(
                                              'Rp${Utils.numberFormat(cart.item.price)}',
                                              style: StyleText.textPrimary(),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () => controller.reduceQty(
                                                  index: index),
                                              child: const Icon(
                                                Icons.remove,
                                                size: 12,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              child: Text(
                                                cart.qty.toString(),
                                                style: StyleText.textBlack(),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => controller.addQty(
                                                  index: index),
                                              child: const Icon(
                                                Icons.add,
                                                size: 12,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Sisa stok: ${cart.item.stock}',
                                                style: StyleText.textRed(),
                                                textAlign: TextAlign.end,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: InkWell(
                                      onTap: () {
                                        controller.deleteCart(index: index);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: controller.carts.length),
                    ),
                  ),
                  const CustomDivider(),
                  _buildPaymentMethod(),
                  const CustomDivider(),
                  _buildPrice()
                ],
              ),
      ),
    );
  }

  Widget _buildReceiver() {
    return InkWell(
      onTap: () {
        Get.to(
          () => ReceiverScreen(
            receiverData: controller.receiver.value,
            privileges: controller.privileges,
            selectedPrivilege: controller.selectedPrivilege.value,
          ),
        )?.then((value) {
          if (value != null) {
            controller.receiver(value);
            controller.selectedPrivilege(value.privilegeName);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => controller.receiver.value == null
              ? Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                    Text(
                      'Tambah Penerima',
                      style: StyleText.textPrimary(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penerima: ',
                      style: StyleText.textBlack(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          controller.receiver.value!.name,
                          style: StyleText.textBlack(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(Get.context!).primaryColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                controller.selectedPrivilege.value,
                                style: StyleText.textPrimary(fontSize: 12),
                              ),
                            ),
                            Text(
                              'Diskon: ${controller.getPrivilegeDiscount()}%',
                              style: StyleText.textGrey(fontSize: 10),
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      controller.receiver.value!.phone,
                      style: StyleText.textBlack(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.receiver.value!.address,
                      style: StyleText.textBlack(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _buildPaymentMethod() => InkWell(
        onTap: () => _showPaymentMethodSheet(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Metode Pembayaran',
                style: StyleText.textBlack(),
              ),
              const Spacer(),
              Text(
                controller.selectedMethod.string,
                style: StyleText.textPrimary(),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(Get.context!).primaryColor,
                size: 14,
              )
            ],
          ),
        ),
      );

  _showPaymentMethodSheet() {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pilih Metode Pembayaran',
              style: StyleText.textBlack(fontWeight: FontWeight.w600),
            ),
            const Divider(),
            ...controller.paymentMethods.map(
              (element) => InkWell(
                onTap: () {
                  controller.selectedMethod(element.method);
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(element.method),
                      const Spacer(),
                      Visibility(
                        visible:
                            controller.selectedMethod.value == element.method,
                        child: Icon(
                          Icons.done,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildPrice() => Visibility(
        visible: controller.isAllItemAvailable(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total: ',
                    style: StyleText.textBlack(),
                  ),
                  Text(
                    'Rp${Utils.numberFormat(controller.calculateTotalPrice())}',
                    style: StyleText.textPrimary(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Termasuk pajak 11%',
                    style: StyleText.textGrey(fontSize: 10),
                  ),
                ],
              ),
              const Spacer(),
              LoadingButton(
                  text: controller.isOrderCreated.value
                      ? 'Lihat Invoice'
                      : 'Buat Order',
                  onPressed: () {
                    controller.isOrderCreated.value
                        ? Get.off(() => const InvoiceScreen(),
                            binding: InvoiceBinding(),
                            arguments: controller.newOrder.value!.data.id)
                        : controller.createOrder();
                  },
                  isLoading: false)
            ],
          ),
        ),
      );
}
