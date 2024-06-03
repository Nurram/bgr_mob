import 'package:bgr_logistik/core/repositories/order_detail_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/home_controller.dart';
import 'package:bgr_logistik/models/order_request.dart';
import 'package:bgr_logistik/models/order_response.dart';
import 'package:bgr_logistik/models/payment_method_response.dart';
import 'package:bgr_logistik/models/privileges_response.dart';

import '../../models/cart_data.dart';
import '../../models/receiver_data.dart';

class OrderDetailController extends GetxController {
  final repo = Get.find<OrderDetailRepository>();
  final authController = Get.find<AuthController>();

  final carts = <CartData>[].obs;
  final paymentMethods = <PaymentMethodDatum>[].obs;
  final privileges = <PrivilegeDatum>[].obs;

  final Rx<OrderResponse?> newOrder = Rx(null);
  final Rx<ReceiverData?> receiver = Rx(null);

  final selectedMethod = "Cash".obs;
  final selectedPrivilege = ''.obs;

  final isLoading = true.obs;
  final isOrderCreated = false.obs;

  fetchDatas({bool fetchAdditions = true}) async {
    isLoading(true);

    try {
      final ids = <int>[];

      for (var element in carts) {
        ids.add(element.item.id);
      }

      final response = await repo.getDetails(ids: ids);

      for (var i = 0; i < carts.length; i++) {
        final item = carts[i].item;
        carts[i].item =
            response.data.firstWhere((element) => element.id == item.id);
      }

      if (fetchAdditions) {
        final privilegeResponse = await repo.getPrivileges();
        privileges.clear();
        privileges.addAll(privilegeResponse.data);
        selectedPrivilege(privileges.first.name);

        final paymentResponse = await repo.getPaymentMethod();
        paymentMethods.clear();
        paymentMethods.addAll(paymentResponse.data);
        selectedMethod(paymentMethods.first.method);
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addQty({required int index}) {
    final cart = carts[index];

    if (cart.qty + 1 < 999) {
      carts[index].qty += 1;
    }

    carts.refresh();
  }

  reduceQty({required int index}) {
    final cart = carts[index];

    if (cart.qty - 1 > 0) {
      carts[index].qty -= 1;
    }

    carts.refresh();
  }

  bool isAllItemAvailable() {
    bool isAvailable = true;

    final carts =
        this.carts.where((element) => element.qty > element.item.stock);
    if (carts.isNotEmpty) isAvailable = false;
    if (receiver.value == null) isAvailable = false;

    return isAvailable;
  }

  double calculatePrice() {
    double totalPrice = 0;

    for (var element in carts) {
      totalPrice += element.qty * element.item.price;
    }

    return totalPrice;
  }

  double calculateTotalPrice() {
    double totalPrice = calculatePrice();

    final privilege = privileges
        .firstWhere((element) => element.name == selectedPrivilege.value);

    totalPrice -= (totalPrice * privilege.discountPercent / 100);
    totalPrice += (totalPrice * 11 / 100);

    return totalPrice;
  }

  createOrder() async {
    isLoading(true);

    try {
      final userId = authController.loggedInUser.value!.id!;
      final payment = paymentMethods
          .firstWhere((element) => element.method == selectedMethod.value);
      final items = <OrderItem>[];

      for (var element in carts) {
        items.add(OrderItem(id: element.item.id, qty: element.qty));
      }

      final request = OrderRequest(
          userId: userId,
          paymentId: payment.id,
          receiverName: receiver.value!.name,
          receiverAddress: receiver.value!.address,
          receiverPhone: receiver.value!.phone,
          privilegeId: receiver.value!.privilegeId,
          price: calculatePrice(),
          priceAfterTax: calculateTotalPrice(),
          items: items);
      final response = await repo.createOrder(request: request);
      newOrder(response);

      await fetchDatas(fetchAdditions: false);

      final homeController = Get.find<HomeController>();
      await homeController.searchItem();
      homeController.carts.clear();

      isLoading(false);
      isOrderCreated(true);

      Utils.showGetSnackbar('Sukses Membuat Order', true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  int getPrivilegeDiscount() {
    return privileges
        .firstWhere((element) => element.name == selectedPrivilege.value)
        .discountPercent;
  }

  deleteCart({required int index}) {
    carts.removeAt(index);
    Get.find<HomeController>().carts.removeAt(index);

    if (carts.isEmpty) {
      Get.back();
    }
  }

  @override
  void onInit() {
    carts.addAll(Get.arguments);
    fetchDatas();

    super.onInit();
  }
}
