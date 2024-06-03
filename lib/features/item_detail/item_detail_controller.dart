import 'package:bgr_logistik/core/repositories/item_repository.dart';
import 'package:bgr_logistik/core/repositories/uom_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/items_response.dart';
import 'package:bgr_logistik/models/uoms_response.dart';

class ItemDetailController extends GetxController {
  final uomRepo = Get.find<UomRepository>();
  final repo = Get.find<ItemRepository>();

  final key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final skuCtr = TextEditingController();
  final stockCtr = TextEditingController();
  final priceCtr = TextEditingController();

  final isLoading = false.obs;
  final selectedUom = ''.obs;

  final Rx<ItemDatum?> item = Rx(null);
  final uoms = <UomDatum>[].obs;

  @override
  void onInit() async {
    final args = Get.arguments;
    await getUom();

    if (args != null) {
      item(args);
      nameCtr.text = item.value!.name;
      skuCtr.text = item.value!.sku.toString();
      stockCtr.text = item.value!.stock.toString();
      priceCtr.text = item.value!.price.toString();

      final uom = uoms.firstWhere((element) => element.id == item.value!.uomId);
      selectedUom(uom.name);
    }

    super.onInit();
  }

  getUom() async {
    isLoading(true);

    try {
      final response = await uomRepo.getDatas();
      uoms(response.data);
      selectedUom(uoms.first.name);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  editItem() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.update(body: {
        'id': item.value!.id,
        'name': nameCtr.text,
        'stock': stockCtr.text,
        'sku': item.value!.sku,
        'uomId':
            uoms.firstWhere((element) => element.name == selectedUom.value).id,
        'price': priceCtr.text,
      });

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addItem() async {
    if (!key.currentState!.validate()) return;
    isLoading(true);

    try {
      await repo.insert(body: {
        'name': nameCtr.text,
        'stock': stockCtr.text,
        'sku': skuCtr.text,
        'uomId':
            uoms.firstWhere((element) => element.name == selectedUom.value).id,
        'price': priceCtr.text
      });

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  deleteItem() async {
    isLoading(true);

    try {
      await repo.delete(id: item.value!.id);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
