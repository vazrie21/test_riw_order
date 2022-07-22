import 'package:get/get.dart';

import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/detail_order/bindings/detail_order_binding.dart';
import '../modules/detail_order/views/detail_order_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/invoice/bindings/invoice_binding.dart';
import '../modules/invoice/views/invoice_view.dart';
import '../modules/riwayat_order/bindings/riwayat_order_binding.dart';
import '../modules/riwayat_order/views/riwayat_order_view.dart';
import '../modules/status_pengiriman/bindings/status_pengiriman_binding.dart';
import '../modules/status_pengiriman/views/status_pengiriman_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_ORDER,
      page: () => const RiwayatOrderView(),
      binding: RiwayatOrderBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ORDER,
      page: () => const DetailOrderView(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE,
      page: () => InvoiceView(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: _Paths.STATUS_PENGIRIMAN,
      page: () => const StatusPengirimanView(),
      binding: StatusPengirimanBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
  ];
}
