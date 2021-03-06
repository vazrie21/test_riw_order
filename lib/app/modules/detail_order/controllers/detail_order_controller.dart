import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

class DetailOrderController extends GetxController {
  var orderId = Get.arguments;
  var orderD = {}.obs;
  var orderI = [].obs;
  var orderB = {}.obs;
  var orderS = {}.obs;
  var url = Uri.parse(
      "https://dapurcokelat.com/api/order/getorder?token=xx&orderid=${Get.arguments}");

  var tglOrder = "".obs;
  var tglKirim = "".obs;
  var statusOrder = "".obs;
  var Sloading = false.obs;

  var curStep = 3.obs;
  var complet = false.obs;

  var statusTrx = 0.obs;

  Future<void> dataOrder() async {
    http.Response response = await http.get(url);
    var res = json.decode(response.body);
    var order = res['data'];
    orderD.value = order['order'];
    orderI.value = order['order_item'];
    orderB.value = order['order_billing'];
    orderS.value = order['order_shipping'];
    tglOrder.value =
        Jiffy(orderD['order_date'].toString()).format("dd MMM yyyy, HH:mm");

    tglKirim.value =
        Jiffy("${orderD['delivery_date']} ${orderD['delivery_time']}")
            .format("dd MMM yyyy, HH:mm");
    res['status'] == "success" ? Sloading.value = true : Sloading.value = false;

    if (orderD['order_status'] == "Open") {
      statusTrx.value = 1;
      statusOrder.value = "Menunggu Pembayaran";
      if (orderD['bill_statusx'] != "Pending") {
        statusTrx.value = 2;
        statusOrder.value = "Pesanan Diperoses";
        if (orderD['ship_statusx'] != "Pending") {
          statusTrx.value = 3;
          statusOrder.value = orderD['ship_statusx'];
          if (orderD['ship_statusx'] == "Shipped") {
            statusTrx.value = 4;
            statusOrder.value = orderD['ship_statusx'];
          }
        }
      }
    } else {
      statusTrx.value = 0;
      statusOrder.value = "Dibatalkan";
    }
    print(statusOrder);
  }

  @override
  void onReady() {
    super.onReady();
    dataOrder();
  }
}
