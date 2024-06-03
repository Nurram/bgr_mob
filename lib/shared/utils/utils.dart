import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core_imports.dart';

class Utils {
  static String dateFromMillis(int millis) {
    final date = DateTime.fromMillisecondsSinceEpoch(millis);
    final formatted = DateFormat('dd MMMM yyyy').format(date);

    return formatted;
  }

  static showGetSnackbar(String msg, bool success) {
    Get.snackbar(
      success ? 'Success!' : 'Error!',
      msg,
      backgroundColor: success ? Colors.green : Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      borderRadius: 0,
      margin: EdgeInsets.zero,
    );
  }

  static String formatDateFromMillis(
      {required String pattern, required int millis}) {
    final date = DateTime.fromMillisecondsSinceEpoch(millis);
    final format = DateFormat(pattern);

    return format.format(date);
  }

  static String formatDate({required String pattern, required DateTime date}) {
    final format = DateFormat(pattern);

    return format.format(date);
  }

  static String numberFormat(num number) {
    final oCcy = NumberFormat("#,##0", "en_US");
    return oCcy.format(number);
  }

  static Future<void> storeToSecureStorage(
      {required String key, required String data}) async {
    final storage = Get.find<FlutterSecureStorage>();
    await storage.write(key: key, value: data);
  }

  static Future<String?> readFromSecureStorage({required String key}) async {
    final storage = Get.find<FlutterSecureStorage>();
    return await storage.read(key: key);
  }

  static Future clearSecureStorage() async {
    final storage = Get.find<FlutterSecureStorage>();
    await storage.deleteAll();
  }

  static String getAssetPath({required String imageName}) {
    return 'assets/$imageName';
  }

  static bool isFormValidated({required GlobalKey<FormState> key}) {
    if (key.currentState == null) return false;
    return key.currentState!.validate();
  }

  static double getHeightWithoutAppBar(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
