import 'dart:io';

import 'package:bgr_logistik/core_imports.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../shared/widgets/alert_dialog.dart';
import 'invoice_controller.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
            _shareInvoice();
          },
          child: const Icon(Icons.share),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Print Invoice',
                message: 'To be develop later by me in BLI',
                onConfirm: () {
                  Get.back();
                },
              ),
            );
          },
          child: const Icon(Icons.print),
        ),
        const SizedBox(width: 16),
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

  _shareInvoice() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return _buildPdf();
          }),
    );

    final output = await getTemporaryDirectory();
    String fileName = '${controller.invoice.value!.invoice}.pdf';
    fileName = fileName.replaceAll('/', '_');
    final path = '${output.path}/$fileName';
  
    final file = File(path);
    if (!(await file.exists())) {
      await file.create();
      await file.writeAsBytes(await pdf.save());
    }

    await Share.shareXFiles([XFile(path)], text: fileName);
  }

  pw.Widget _buildPdf() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'BGR Logistik Indonesia',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          'Jalan Kali Besar Timur No. 5-7, RT.3/RW.6, Kec. Taman Sari, Kota Jakarta Barat, DKI Jakarta ',
          style: const pw.TextStyle(fontSize: 12),
        ),
        pw.SizedBox(height: 24),
        pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Text(
            'INVOICE',
            style: const pw.TextStyle(fontSize: 16),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Text(
            controller.invoice.value!.invoice,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 24),
        pw.Table(
          children: [
            pw.TableRow(children: [
              _buildPwTableCell(text: 'Customer'),
              _buildPwTableCell(text: ''),
              _buildPwTableCell(text: ''),
              _buildPwTableCell(text: 'Tanggal:'),
              _buildPwTableCell(
                text: Utils.formatDate(
                  pattern: 'dd MMMM yyyy',
                  date: controller.invoice.value!.createdAt.toLocal(),
                ),
              ),
            ]),
            pw.TableRow(children: [
              _buildPwTableCell(text: 'Nama:'),
              _buildPwTableCell(text: controller.invoice.value!.receiverName),
              _buildPwTableCell(text: ''),
              _buildPwTableCell(text: ''),
              _buildPwTableCell(text: ''),
            ]),
            pw.TableRow(children: [
              _buildPwTableCell(text: 'Alamat:'),
              _buildPwTableCell(
                  text: controller.invoice.value!.receiverAddress),
              _buildPwTableCell(text: ''),
              _buildPwTableCell(text: ''),
              _buildPwTableCell(text: ''),
            ]),
            pw.TableRow(children: [
              _buildPwTableCell(text: 'Telepon:'),
              _buildPwTableCell(text: controller.invoice.value!.receiverPhone),
              _buildPwTableCell(text: ''),
              _buildPwTableCell(text: ''),
              _buildPwTableCell(text: ''),
            ]),
          ],
        ),
        pw.SizedBox(height: 32),
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(children: [
              _buildPwTableCell(text: 'Nama', center: true),
              _buildPwTableCell(text: 'Jumlah', center: true),
              _buildPwTableCell(text: 'Harga', center: true),
              _buildPwTableCell(text: 'Total', center: true),
            ]),
            ...controller.invoice.value!.orderLines.map(
              (e) => pw.TableRow(children: [
                _buildPwTableCell(text: e.itemName, center: true),
                _buildPwTableCell(text: '${e.qty} ${e.uom}', center: true),
                _buildPwTableCell(
                    text: 'Rp${Utils.numberFormat(e.itemPrice)}', center: true),
                _buildPwTableCell(
                    text: 'Rp${Utils.numberFormat(
                      controller.getItemPrice(data: e),
                    )}',
                    center: true),
              ]),
            ),
            pw.TableRow(children: [
              _buildPwTableCell(text: 'Diskon', center: true),
              _buildPwTableCell(
                  text: '${controller.invoice.value!.discountPercent} %',
                  center: true),
              _buildPwTableCell(
                  text: 'Rp${Utils.numberFormat(
                    controller.calculateDiscout(),
                  )}'
                      .toString(),
                  center: true),
              _buildPwTableCell(
                  text: 'Rp${Utils.numberFormat(
                    controller.getPriceAfterDiscount(),
                  )}',
                  center: true),
            ]),
            pw.TableRow(children: [
              _buildPwTableCell(text: 'Pajak', center: true),
              _buildPwTableCell(text: '11', center: true),
              _buildPwTableCell(text: '%', center: true),
              _buildPwTableCell(
                  text: 'Rp${Utils.numberFormat(
                    controller.calculateTax(),
                  )}',
                  center: true),
            ]),
            pw.TableRow(children: [
              _buildPwTableCell(text: 'TOTAL', center: true),
              _buildPwTableCell(text: '', center: true),
              _buildPwTableCell(text: '', center: true),
              _buildPwTableCell(
                  text: 'Rp${Utils.numberFormat(
                    controller.getTotalPrice(),
                  )}',
                  center: true),
            ]),
          ],
        ),
        pw.SizedBox(height: 80),
        pw.Padding(
          padding: const pw.EdgeInsets.all(16),
          child: pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Column(
              children: [
                pw.Text('BGR Logistik Indonesia'),
                pw.SizedBox(height: 56),
                pw.Text('(Manager Penjualan)'),
              ],
            ),
          ),
        )
      ],
    );
  }

  pw.Widget _buildPwTableCell({required String text, bool center = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 12),
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
      ),
    );
  }
}
