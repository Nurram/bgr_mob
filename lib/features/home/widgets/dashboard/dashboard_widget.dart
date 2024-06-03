import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/widgets/dashboard/dashboard_controller.dart';
import 'package:bgr_logistik/features/home/widgets/dashboard/widgets/sales_widget.dart';

class DashboardWidget extends GetView<DashboardController> {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              _buildChip(label: 'Penjualan'),
              const SizedBox(width: 8),
              _buildChip(label: 'Stock'),
            ],
          ),
          const SizedBox(height: 24),
          controller.selectedChip.value == 'Penjualan'
              ? const SalesWidget()
              : const SalesWidget()
        ],
      ),
    );
  }

  Widget _buildChip({required String label}) {
    final isSelected = controller.selectedChip.value == label;

    return InkWell(
      onTap: () {
        controller.selectedChip(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(Get.context!).primaryColor
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: isSelected ? StyleText.textWhite() : StyleText.textBlack(),
        ),
      ),
    );
  }
}
