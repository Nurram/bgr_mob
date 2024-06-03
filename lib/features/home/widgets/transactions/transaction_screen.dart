import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/widgets/transactions/transaction_controller.dart';
import 'package:bgr_logistik/features/invoice/invoice_binding.dart';
import 'package:bgr_logistik/features/invoice/invoice_screen.dart';

class TransactionWidget extends GetView<TransactionController> {
  const TransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => controller.fetchData(),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    final item = controller.transactions[index];

                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => const InvoiceScreen(),
                          binding: InvoiceBinding(),
                          arguments: item.id,
                        );
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
                                    item.receiverName,
                                    style: StyleText.textBlack(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Text(
                                  "IDR${Utils.numberFormat(item.priceAfterTax)}",
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
                                  item.invoice,
                                  style: StyleText.textBlack(fontSize: 12),
                                ),
                                const Spacer(),
                                Text(
                                  Utils.formatDate(
                                      pattern: 'dd MMMM yyyy',
                                      date: item.createdAt),
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
    );
  }
}
