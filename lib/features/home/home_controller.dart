import 'dart:convert';

import 'package:bgr_logistik/core/repositories/home_repository.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/home/widgets/find_item.dart';
import 'package:bgr_logistik/features/home/widgets/items/item_widget.dart';
import 'package:bgr_logistik/features/home/widgets/payment_methods/payment_method_widget.dart';
import 'package:bgr_logistik/features/home/widgets/privileges/privileges_widget.dart';
import 'package:bgr_logistik/features/home/widgets/roles/role_widget.dart';
import 'package:bgr_logistik/features/home/widgets/transactions/transaction_screen.dart';
import 'package:bgr_logistik/features/home/widgets/uoms/uom_widget.dart';
import 'package:bgr_logistik/features/home/widgets/users/users_widget.dart';
import 'package:bgr_logistik/models/cart_data.dart';
import 'package:bgr_logistik/models/item_search_response.dart';
import 'package:bgr_logistik/models/role_permission_response.dart';

import '../../models/user_data.dart';
// import 'widgets/dashboard/dashboard_widget.dart';
import 'widgets/permissions/permission_widget.dart';

class HomeController extends GetxController {
  late Rx<UserData?> user;

  final repo = Get.find<HomeRepository>();

  final searchCtr = TextEditingController();

  final titles = <String>[
    'Cari Produk',
    'Riwayat Transaksi',
    'List Unit Of Material',
    'List Item',
    'List Privilege',
    'List Metode Pembayaran',
    'List Role',
    'List Permission',
    'List User',
    // 'Dashboard',
    'Logout'
  ];

  final widgets = <Widget>[
    const FindItemWidget(),
    const TransactionWidget(),
    const UomWidget(),
    const ItemWIdget(),
    const PrivilegesWidget(),
    const PaymentMethodsWidget(),
    const RoleWidget(),
    const PermissionWidget(),
    const UsersWidget(),
    // const DashboardWidget(),
  ];

  final currentIndex = 0.obs;
  final qty = 1.obs;
  final isLoading = false.obs;

  final items = <ItemDatum>[].obs;
  final carts = <CartData>[].obs;
  final permissions = <RolePermissionDatum>[].obs;

  Widget getCurrentWidget() => widgets[currentIndex.value];
  String getTitle() => titles[currentIndex.value];

  searchItem() async {
    if (searchCtr.text.isEmpty) return;

    try {
      isLoading(true);

      final response = await repo.searchItem(query: searchCtr.text);

      items.clear();
      items.addAll(response.data);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addQty() {
    if (qty.value + 1 < 999) {
      qty(qty.value + 1);
    }
  }

  reduceQty() {
    if (qty.value - 1 > 0) {
      qty(qty.value - 1);
    }
  }

  addToCart({required ItemDatum item}) async {
    final isInCart = carts.where((p0) => p0.item.id == item.id).isNotEmpty;

    if (isInCart) {
      final index = carts.indexWhere((element) => element.item.id == item.id);
      carts[index].qty += 1;
      carts.refresh();

      return;
    }

    final cart = CartData(item: item, qty: qty.value);
    carts.add(cart);

    qty(1);
  }

  int calculateCartPrice() {
    int total = 0;

    for (var element in carts) {
      total += (element.qty * element.item.price);
    }

    return total;
  }

  logout() async {
    Get.find<AuthController>().logout();
  }

  @override
  void onInit() async {
    final authCtr = Get.find<AuthController>();
    authCtr.getCurrentLoggedIn();

    user = authCtr.loggedInUser;

    final List<dynamic> savedPermissions = jsonDecode(
      (await Utils.readFromSecureStorage(key: 'permissions'))!,
    );

    for (var element in savedPermissions) {
      final permission = RolePermissionDatum.fromJson(element);
      permissions.add(permission);
    }

    final index = titles.indexOf(
      permissions.firstWhere((element) => element.isActive == 1).name,
    );

    currentIndex(index);

    super.onInit();
  }
}
