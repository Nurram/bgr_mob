import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/home_controller.dart';
import 'package:bgr_logistik/shared/widgets/drawer.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.getTitle()),
        ),
      ),
      body: Obx(
        () => controller.getCurrentWidget(),
      ),
      drawer: Obx(
        () => DrawerWidget(
          name: controller.user.value?.name ?? '',
          role: controller.user.value?.role?.name ?? '',
          titles: controller.titles,
          permission: controller.permissions,
          currentIndex: controller.currentIndex.value,
          onTap: (p0) {
            Get.back();

            if (p0 == 10) {
              controller.logout();
            } else {
              controller.currentIndex(p0);
            }
          },
        ),
      ),
    );
  }
}
