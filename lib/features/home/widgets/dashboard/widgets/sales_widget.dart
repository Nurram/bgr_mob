import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/widgets/dashboard/dashboard_controller.dart';

class SalesWidget extends GetView<DashboardController> {
  const SalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  CustomTextFormField(
                    controller: controller.salesDateCtr,
                    hint: 'Cari disini',
                    readOnly: true,
                    onTap: () {
                      print('TAP');
                    },
                    suffixIcon: InkWell(
                      onTap: () {
                        // controller.searchItem();
                        print('Search');
                      },
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      final item = controller.items[index];

                      return Container(
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
                                  fontSize: 16, fontWeight: FontWeight.w500),
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
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
