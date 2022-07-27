import 'package:get/get.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController
  // var cartA = [].obs;
  var dio = Dio();
  var pakePoin = Colors.grey[400].obs;
  var isPoint = false.obs;
  var pointC = 100.obs;
  var adrCust = [].obs;
  var adrDef = {}.obs;
  var cartA = <Map<String, String>>[
    {
      "item_id": "57626",
      "order_id": "202204230059291AP0000048",
      "product_id": "1771",
      "data_id": "0",
      "product_title": "Fudge Brownies",
      "option_1": "",
      "variant_1": "",
      "option_2": "",
      "variant_2": "",
      "option_3": "",
      "variant_3": "",
      "quantity": "2",
      "price": "80000",
      "ship_status": "Pending",
      "ship_date": "2022-04-23 00:59:29",
      "remark": "abc",
      "ship_name": "",
      "ship_code": "",
      "ship_url": "",
      "baseprice": "80000",
      "img":
          "https:\/\/dapurcokelat.com\/assets\/uploads\/products\/thumbs\/400x400\/IMG_6108.jpg"
    },
    {
      "item_id": "57627",
      "order_id": "202204230059291AP0000048",
      "product_id": "1317",
      "data_id": "0",
      "product_title": "Black Forest",
      "option_1": "Size",
      "variant_1": "Diameter 18cm",
      "option_2": "",
      "variant_2": "",
      "option_3": "",
      "variant_3": "",
      "quantity": "1",
      "price": "270000",
      "ship_status": "Pending",
      "ship_date": "2022-04-23 00:59:29",
      "remark": "dsff",
      "ship_name": "",
      "ship_code": "",
      "ship_url": "",
      "baseprice": "270000",
      "img":
          "https:\/\/dapurcokelat.com\/assets\/uploads\/products\/thumbs\/400x400\/GRAB_FOOD.jpg"
    }
  ];

  var isDelivery = true.obs;

  var lat = "-6.3398059".obs;
  var lng = "106.6862787".obs;
  var allOutlet = [].obs;
  var outletTerdekat = [].obs;
  var allArea = [].obs;

  var daftarBank = [].obs;
  var outletTerpilih = {}.obs;
  var alamatTerpilih = {}.obs;
  var metodeBayar = {}.obs;

  Future<void> getAlloutlet() async {
    var res = await dio.post(
        'https://dapurcokelat.com/api/firebase/getalllocation',
        data: {'token': 'xx', 'lat': '$lat', 'lng': '$lng'});
    print(res.data);
    outletTerdekat.value = res.data['terdekat'];
    allOutlet.value = res.data['data'];
    allArea.value = res.data['area'];
  }

  Future<void> getAdr() async {
    var res1 = await dio.get(
        'https://dapurcokelat.com/api/order/addressList?token=xx&custid=11');
    adrCust.value = res1.data['data'];
    adrCust.isNotEmpty ? adrDef.value = adrCust[0] : [];
    // print('isi : $adrCust');
  }

  @override
  void onReady() {
    super.onReady();
    getAlloutlet();
    getAdr();
  }
}
