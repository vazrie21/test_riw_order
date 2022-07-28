import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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

class RiwayatOrderController extends GetxController {
  List<dynamic> dumy = [
    {
      "notrx": "0123456789DCD01",
      "jumlahproduk": "2",
      "total": "500000",
      "statuskirim": "menunggu pick-up kurir",
      "statusorder": "paid",
    },
    {
      "notrx": "0123456789DCD02",
      "jumlahproduk": "2",
      "total": "500000",
      "statuskirim": "menunggu pick-up kurir",
      "statusorder": "paid",
    },
    {
      "notrx": "0123456789DCD03",
      "jumlahproduk": "2",
      "total": "500000",
      "statuskirim": "menunggu pick-up kurir",
      "statusorder": "paid",
    },
    {
      "notrx": "0123456789DCD04",
      "jumlahproduk": "2",
      "total": "500000",
      "statuskirim": "menunggu pick-up kurir",
      "statusorder": "paid",
    },
    {
      "notrx": "0123456789DCD05",
      "jumlahproduk": "2",
      "total": "500000",
      "statuskirim": "menunggu pick-up kurir",
      "statusorder": "paid",
    },
    {
      "notrx": "0123456789DCD05",
      "jumlahproduk": "2",
      "total": "500000",
      "statuskirim": "menunggu pick-up kurir",
      "statusorder": "paid",
    },
  ].obs;
  var orderList = [].obs;
  var url = Uri.parse(
      'https://dapurcokelat.com/api/order/orderlist?token=xx&custid=2043');

  Future<void> dataOrder() async {
    http.Response response = await http.get(url);
    var order = json.decode(response.body)['data'];
    orderList.value = order;
    // var orderItem = order[0]['order_item'].length;
    // print(orderList);
    // print
  }

  @override
  void onReady() {
    super.onReady();
    dataOrder();

    _getStoragePermission();
    // print(orderList);
  }

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      // permissionGranted = true;
    }
  }
}
