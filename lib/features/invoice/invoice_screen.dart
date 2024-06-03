import 'package:bgr_logistik/core_imports.dart';
import 'package:flutter/services.dart';

import '../../shared/widgets/alert_dialog.dart';
import 'invoice_controller.dart';

class InvoiceScreen extends GetView<InvoiceController> {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title: const Text('Invoice'), actions: [
        InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Print Invoice',
                  message: 'To be develop later in BLI with me',
                  onConfirm: () {
                    Get.back();
                  },
                ),
              );
            },
            child: const Icon(Icons.print)),
      ]),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => controller.getOrderDetail(),
                  child: ListView(
                    children: [
                      Text(
                        'BGR Logistik Indonesia',
                        style: StyleText.textBlack(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Jalan Kali Besar Timur No. 5-7, RT.3/RW.6, Kec. Taman Sari, Kota Jakarta Barat, DKI Jakarta ',
                        style: StyleText.textBlack(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'INVOICE',
                          style: StyleText.textBlack(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          controller.invoice.value!.invoice,
                          style:
                              StyleText.textBlack(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Table(
                        children: [
                          TableRow(children: [
                            _buildTableCell(text: 'Customer'),
                            _buildTableCell(text: ''),
                            _buildTableCell(text: ''),
                            _buildTableCell(text: 'Tanggal:'),
                            _buildTableCell(
                              text: Utils.formatDate(
                                pattern: 'dd MMMM yyyy',
                                date: controller.invoice.value!.createdAt
                                    .toLocal(),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            _buildTableCell(text: 'Nama:'),
                            _buildTableCell(
                                text: controller.invoice.value!.receiverName),
                            _buildTableCell(text: ''),
                            _buildTableCell(text: ''),
                            _buildTableCell(text: ''),
                          ]),
                          TableRow(children: [
                            _buildTableCell(text: 'Alamat:'),
                            _buildTableCell(
                                text:
                                    controller.invoice.value!.receiverAddress),
                            _buildTableCell(text: ''),
                            _buildTableCell(text: ''),
                            _buildTableCell(text: ''),
                          ]),
                          TableRow(children: [
                            _buildTableCell(text: 'Telepon:'),
                            _buildTableCell(
                                text: controller.invoice.value!.receiverPhone),
                            _buildTableCell(text: ''),
                            _buildTableCell(text: ''),
                            _buildTableCell(text: ''),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            _buildTableCell(text: 'Nama', center: true),
                            _buildTableCell(text: 'Jumlah', center: true),
                            _buildTableCell(text: 'Harga', center: true),
                            _buildTableCell(text: 'Total', center: true),
                          ]),
                          ...controller.invoice.value!.orderLines.map(
                            (e) => TableRow(children: [
                              _buildTableCell(text: e.itemName, center: true),
                              _buildTableCell(
                                  text: '${e.qty} ${e.uom}', center: true),
                              _buildTableCell(
                                  text: 'Rp${Utils.numberFormat(e.itemPrice)}',
                                  center: true),
                              _buildTableCell(
                                  text: 'Rp${Utils.numberFormat(
                                    controller.getItemPrice(data: e),
                                  )}',
                                  center: true),
                            ]),
                          ),
                          TableRow(children: [
                            _buildTableCell(text: 'Diskon', center: true),
                            _buildTableCell(
                                text:
                                    '${controller.invoice.value!.discountPercent} %',
                                center: true),
                            _buildTableCell(
                                text: 'Rp${Utils.numberFormat(
                                  controller.calculateDiscout(),
                                )}'
                                    .toString(),
                                center: true),
                            _buildTableCell(
                                text: 'Rp${Utils.numberFormat(
                                  controller.getPriceAfterDiscount(),
                                )}',
                                center: true),
                          ]),
                          TableRow(children: [
                            _buildTableCell(text: 'Pajak', center: true),
                            _buildTableCell(text: '11', center: true),
                            _buildTableCell(text: '%', center: true),
                            _buildTableCell(
                                text: 'Rp${Utils.numberFormat(
                                  controller.calculateTax(),
                                )}',
                                center: true),
                          ]),
                          TableRow(children: [
                            _buildTableCell(text: 'TOTAL', center: true),
                            _buildTableCell(text: '', center: true),
                            _buildTableCell(text: '', center: true),
                            _buildTableCell(
                                text: 'Rp${Utils.numberFormat(
                                  controller.getTotalPrice(),
                                )}',
                                center: true),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              Text(
                                'BGR Logistik Indonesia',
                                style: StyleText.textBlack(),
                              ),
                              const SizedBox(height: 56),
                              Text(
                                '(Manager Penjualan)',
                                style: StyleText.textBlack(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTableCell({required String text, bool center = false}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          text,
          style: StyleText.textBlack(fontSize: 12),
          textAlign: center ? TextAlign.center : TextAlign.left,
        ),
      ),
    );
  }
}
