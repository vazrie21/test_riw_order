import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
  }
}
