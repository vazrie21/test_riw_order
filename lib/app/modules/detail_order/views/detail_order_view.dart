// import 'dart:html';

// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
// import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:test_riw_order/app/modules/checkout/views/checkout_view.dart';
import 'package:test_riw_order/app/routes/app_pages.dart';
import '../controllers/detail_order_controller.dart';

final cokelat = Colors.brown.shade700;

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
    final tinggiLayar = MediaQuery.of(context).size.height;
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = tinggiLayar;
    final cokelat = Colors.brown.shade700;

    var dataDelivery = {}.obs;
    dataDelivery = controller.dataReq;

    var indexnya = 0.obs;
    // indexnya = controller.indexStatus;
    indexnya.value = 4;

    Widget data3(int indexnya) {
      var gambar;
      var judul;
      var subtitle;
      var waktu;
      if (indexnya == 0) {
        gambar = Icon(Icons.payment);
        judul = Text("ORDER DIBATALKAN");
        subtitle = SizedBox(height: 0);
        waktu = SizedBox(height: 0);
      } else if (indexnya == 1) {
        gambar = Icon(Icons.payment);
        judul = Text("MENUNGGU PEMBAYARAN");
        subtitle = SizedBox(height: 0);
        waktu = SizedBox(height: 0);
      } else if (indexnya == 2) {
        gambar = Icon(Icons.store);
        judul = Text("PESANAN SUDAH DITERIMA");
        subtitle = Text("Akan diperoses di Outlet Terpilih");
        waktu = SizedBox(height: 0);
      } else if (indexnya == 3) {
        gambar = Icon(Icons.delivery_dining_outlined);
        judul = Text("MENUNGGU PROSES PICK-UP");
        subtitle = Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dataDelivery.isNotEmpty
                  ? Text(
                      "Driver : ${dataDelivery['driver']['name'].toString()} ")
                  : Text(''),
              Icon(Icons.delivery_dining_outlined, size: 15, color: cokelat),
            ],
          ),
        );
        waktu = Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dataDelivery.isNotEmpty
                  ? Text(
                      "Perkiraan waktu pick-up : ${dataDelivery['timeline']['pickup']} ")
                  : Text(''),
              Icon(Icons.access_time_rounded, size: 15, color: cokelat),
            ],
          ),
        );
      } else {
        gambar = Image.asset('assets/img/ceklis.png');
        judul = Text("PESANANMU SUDAH SAMPAI");
        subtitle = Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dataDelivery.isNotEmpty
                  ? Text(
                      "Diterima oleh : ${dataDelivery['recipient']['firstName'].toString()} ")
                  : Text(''),
              // Icon(Icons.phone_iphone, size: 15, color: cokelat),
            ],
          ),
        );
        waktu = Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dataDelivery.isNotEmpty
                  ? Text("Pada : ${dataDelivery['timeline']['completed']} ")
                  : Text(''),
              Icon(Icons.access_time_rounded, size: 15, color: cokelat),
            ],
          ),
        );
      }

      // return Obx(() {
      return Container(
        padding: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              //gambar
              SizedBox(
                height: 100,
                child: gambar,
              ),
              Container(
                child: Column(
                  children: [
                    // Title
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: judul,
                    ),

                    subtitle,
                    waktu,
                  ],
                ),
              )
            ],
          ),
        ),
      );
      // });
    }

    Widget iconTick(int status) {
      return (status == 0)
          ? Icon(
              Icons.payment,
              color: cokelat,
            )
          : (status == 1)
              ? Icon(
                  Icons.store,
                  color: cokelat,
                )
              : (status == 2)
                  ? Icon(
                      Icons.delivery_dining_outlined,
                      color: cokelat,
                    )
                  : Icon(
                      Icons.home_outlined,
                      color: cokelat,
                    );
    }

    Widget tick(bool isChecked, int status) {
      return isChecked
          ? Column(
              children: [
                SizedBox(
                  height: 50,
                  child: iconTick(status),
                ),
                Icon(
                  Icons.check_circle,
                  color: cokelat,
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: 50,
                  child: iconTick(status),
                ),
                Icon(
                  Icons.radio_button_unchecked,
                  color: cokelat,
                ),
              ],
            );
    }

    Widget line(bool isChecked) {
      return isChecked
          ? Column(children: [
              SizedBox(
                height: 50,
              ),
              Container(
                color: Colors.amber,
                height: 2.0,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ])
          : Column(children: [
              SizedBox(
                height: 50,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1.0,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ]);
    }

    Widget gambarTimeline(int status) {
      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 30),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 4; i++)
              (i < status)
                  ? Row(
                      children: (i == 0)
                          ? [tick(true, i)]
                          : [line(true), tick(true, i)])
                  : Row(
                      children: (i == 0)
                          ? [tick(false, i)]
                          : [line(false), tick(false, i)])
          ],
        ),
      );
    }

    Widget headerA(int indexnya) {
      var judul;
      var logo;
      if (dataDelivery.isNotEmpty) {
        if (indexnya == 1) {
          judul = Text('PROSES DI OUTLET', style: TextStyle(fontSize: 18));
          logo = Icon(Icons.store, size: 30, color: cokelat);
        } else if (indexnya == 2) {
          judul = Text('MENCARI DRIVER', style: TextStyle(fontSize: 18));
          logo = Icon(Icons.search, size: 30, color: cokelat);
        } else if (indexnya == 3) {
          judul =
              Text('MENUNGGU PICK-UP DRIVER', style: TextStyle(fontSize: 18));
          logo = Icon(Icons.location_on_outlined, size: 30, color: cokelat);
        } else if (indexnya == 4) {
          judul = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DRIVER'),
              SizedBox(height: 5),
              Text(
                  "${dataDelivery['driver']['name']} - ${dataDelivery['driver']['phone']}",
                  style: TextStyle(fontSize: 18)),
            ],
          );
          logo = Icon(Icons.phone, size: 30, color: cokelat);
        } else {
          judul = Text('TERKIRIM', style: TextStyle(fontSize: 18));
          logo = Icon(Icons.check_circle_outline, size: 30, color: cokelat);
        }
      } else {
        judul = Text('');
        logo = Icon(Icons.shopping_cart_outlined, size: 30, color: cokelat);
      }
      return Container(
        height: 80,
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Expanded(
                  child: judul,
                ),
                SizedBox(
                  width: 25,
                  child: logo,
                ),
              ],
            ),
          ),
        ),
      );
    }

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
              // status order a
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
                        controller.statusOrder.value,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          alignment: Alignment.centerRight,
                        ),
                        onPressed: () {
                          // Get.toNamed(Routes.STATUS_PENGIRIMAN);
                          showModalBottomSheet(
                            constraints: BoxConstraints(
                              minHeight: 150.0,
                              maxHeight: 400,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            context: context,
                            builder: ((context) {
                              return Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Status Order",
                                      style: hBtebal,
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      height: 1,
                                      width: lebarLayar,
                                      // color: Colors.grey[200],
                                    ),
                                    gambarTimeline(indexnya.value),
                                    data3(indexnya.value),
                                  ],
                                ),
                              );
                            }),
                          );
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
                  orderD['order_cc_discount'] != '0'
                      ? Container(
                          height: 25,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('Poin'),
                              ),
                              Container(
                                child: Text(CurrencyFormat.convertToIdr(
                                    int.parse(
                                        orderD['order_cc_discount'] ?? "0"),
                                    0)),
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  //promo
                  orderD['order_discount'] != "0"
                      ? Container(
                          height: 25,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('Diskon'),
                              ),
                              Container(
                                child: Text(CurrencyFormat.convertToIdr(
                                    int.parse(orderD['order_discount'] ?? "0"),
                                    0)),
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 0,
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
