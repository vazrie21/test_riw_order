// import 'dart:html';

// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
// import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:test_riw_order/app/routes/app_pages.dart';
import '../controllers/detail_order_controller.dart';

class DetailOrderView extends GetView<DetailOrderController> {
  const DetailOrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "Detail Order",
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
        ),
        body: Obx(
          (() {
            return controller.Sloading.value == true
                ? ListView(
                    children: [
                      kepala(context),
                      badan(context),
                      kaki(context),
                      // Container(
                      //   child: Column(
                      //     children: [

                      //     ],
                      //   ),
                      // )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ),
      ),
    );
  }

  Widget kepala(BuildContext context) {
    var orderD = controller.orderD;
    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // status order
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Ini Status Kirim",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          alignment: Alignment.centerRight,
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.STATUS_PENGIRIMAN);
                        },
                        child: Text("Lihat Detail"),
                      ),
                    )
                  ],
                ),
              ),
              //tgl order
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    // order id
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            // color: Colors.red,
                            child: Text(
                              controller.orderId,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            // color: Colors.blue,
                            child: Column(
                              children: [
                                Container(
                                  // color: Colors.red,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        alignment: Alignment.centerRight),
                                    onPressed: () {
                                      Get.toNamed(Routes.INVOICE,
                                          arguments: "${controller.orderId}");
                                      print("in itesting 1");
                                    },
                                    child: Text("Invoice"),
                                  ),
                                ),
                                // Container(child: Text(controller.orderId)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // tgl order
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Tanggal Pembelian"),
                          ),
                          Container(
                            child: Text(
                              controller.tglOrder.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget badan(BuildContext context) {
    var orderD = controller.orderD;
    var orderI = controller.orderI;
    var orderB = controller.orderB;
    var orderShip = controller.orderS;
    String varian = "";
    final lebarLayar = MediaQuery.of(context).size.width;
    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
        ),
        width: lebarLayar,
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < orderI.length; i++)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                  ],
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          child: Image.network(orderI[i]['img']),
                        ),
                        Expanded(
                          child: Container(
                            // color: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 25,
                                  child: Text(
                                    orderI[i]['variant_1'].isEmpty
                                        ? orderI[i]['product_title']
                                        : orderI[i]['product_title'] +
                                            ' - ' +
                                            orderI[i]['variant_1'],
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                    // height: 15,
                                    child: Text(orderI[i]['quantity'] + " X")),
                                Text(CurrencyFormat.convertToIdr(
                                    int.parse(orderI[i]['price']), 0)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  width: 1, color: Colors.grey.shade200),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 20, child: Text("Total")),
                              Text(
                                CurrencyFormat.convertToIdr(
                                    int.parse(orderI[i]['quantity']) *
                                        int.parse(
                                          orderI[i]['price'],
                                        ),
                                    0),
                                style: TextStyle(
                                  // fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget kaki(BuildContext context) {
    final lebarLayar = MediaQuery.of(context).size.width;
    var orderD = controller.orderD;
    var orderB = controller.orderB;
    var orderShip = controller.orderS;

    return Obx(() {
      return Column(
        children: [
          //Info Pengiriman
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ],
            ),
            width: lebarLayar,
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //head info pengiriman
                Container(
                  // color: Colors.green,
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Info Pengiriman',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                // metode pengiriman
                Container(
                  // color: Colors.purple,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        child: Text('Metode Pengiriman'),
                      ),
                      Expanded(
                        child: Text(
                          orderShip['ship_method'] ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                // tgl kirim
                Container(
                  // color: Colors.purple,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        // child: Text('Tgl Pengiriman'),
                      ),
                      Expanded(
                        child: Text(
                          controller.tglKirim.value,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                //no resi
                Container(
                  // color: Colors.pink,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        child: Text('No. Resi'),
                      ),
                      Expanded(
                        child: Text(
                          "123456789",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                //alamat
                Container(
                  // color: Colors.amber,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: lebarLayar,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.red,
                        width: 150,
                        alignment: Alignment.topLeft,
                        child: Text('Alamat'),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderShip['ship_fname'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              orderShip['ship_phone'].toString(),
                              style: TextStyle(
                                  // fontSize: 12,
                                  ),
                            ),
                            Text(
                              orderShip['ship_address'].toString(),
                              style: TextStyle(
                                  // fontSize: 12,
                                  ),
                            ),
                            Text(
                              orderShip['ship_address2'].toString(),
                              style: TextStyle(
                                  // fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          //rincian pembayaran
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ],
            ),
            width: lebarLayar,
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.all(15),
            child: Container(
              // padding: EdgeInsets.all(10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //head rincian pembayarn
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Rincian Pembayaran',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //metode pembayaran
                  Container(
                    height: 25,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1, color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text('Metode Pembayaran')),
                        Container(
                          child: Text(
                            orderB['payment_method'] ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // total harga barang
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Total Harga'),
                        ),
                        Container(
                          child: Text(CurrencyFormat.convertToIdr(
                              int.parse(orderD['order_subtotal'] ?? "0"), 0)),
                        )
                      ],
                    ),
                  ),
                  //ongkir
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Total Ongkos Kirim'),
                        ),
                        Container(
                          child: Text(CurrencyFormat.convertToIdr(
                              int.parse(orderD['order_ship_cost'] ?? "0"), 0)),
                        )
                      ],
                    ),
                  ),
                  //poin
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Poin'),
                        ),
                        Container(
                          child: Text(CurrencyFormat.convertToIdr(
                              int.parse(orderD['order_cc_discount'] ?? "0"),
                              0)),
                        )
                      ],
                    ),
                  ),
                  //promo
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Diskon'),
                        ),
                        Container(
                          child: Text(CurrencyFormat.convertToIdr(
                              int.parse(orderD['order_discount'] ?? "0"), 0)),
                        )
                      ],
                    ),
                  ),
                  // garis bawah
                  Container(
                    height: 10,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1, color: Colors.grey.shade200),
                      ),
                    ),
                  ),
                  // grand total
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total Belanja',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Container(
                          child: Text(
                            CurrencyFormat.convertToIdr(
                                int.parse(orderD['order_total'] ?? "0"), 0),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
