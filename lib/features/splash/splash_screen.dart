import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/splash/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Utils.getAssetPath(imageName: 'logo.png'),
              width: double.infinity,
            ),
            Obx(
              () => Visibility(
                visible: controller.isLoading.value,
                child: const CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
