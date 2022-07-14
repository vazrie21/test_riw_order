import 'package:get/get.dart';

class InvoiceController extends GetxController {
  var orderId = Get.arguments;

  String url = "https://master.dapurcokelat.com/invoice/cetak/${Get.arguments}";
}
