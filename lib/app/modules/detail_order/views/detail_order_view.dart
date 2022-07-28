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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final cokelat = Colors.brown.shade700;

class DetailOrderView extends GetView<DetailOrderController> {
  const DetailOrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'PTSans',
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.grey[800]),
            bodyText2: TextStyle(color: Colors.grey[800]),
          )),
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
    var orderS = controller.orderS;
    final tinggiLayar = MediaQuery.of(context).size.height;
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = tinggiLayar;
    final cokelat = Colors.brown.shade700;

    var indexnya = controller.statusTrx;
    // indexnya.value = 4;

    var visibelDetDeli = false.obs;

    Widget data3(int indexnya) {
      var gambar;
      var judul;
      var subtitle;
      var waktu;
      if (indexnya == 0) {
        gambar = Icon(FontAwesomeIcons.moneyCheck);
        judul = Text("ORDER DIBATALKAN");
        subtitle = SizedBox(height: 0);
        waktu = SizedBox(height: 0);
      } else if (indexnya == 1) {
        gambar = Icon(FontAwesomeIcons.moneyCheck);
        judul = Text("MENUNGGU PEMBAYARAN");
        subtitle = SizedBox(height: 0);
        waktu = SizedBox(height: 0);
      } else if (indexnya == 2) {
        gambar = Icon(Icons.store);
        judul = Text("PESANAN SUDAH DITERIMA");
        subtitle = Text(
            "Akan diperoses di Outlet Dapur Cokelat ${orderS['pickup_store']}");
        waktu = SizedBox(height: 0);
      } else if (indexnya == 3) {
        gambar = Icon(Icons.delivery_dining_outlined);
        judul = Text("MENUNGGU PROSES PICK-UP");
        subtitle = (orderS['ship_method'] != "Delivery")
            ? Text(
                "Di Outlet Dapur Cokelat ${orderS['pickup_store']} - ${controller.tglKirim.value}")
            : Text(
                "Akan dikirim dari Outlet Dapur Cokelat ${orderS['pickup_store']}");
        waktu = SizedBox(height: 0);
      } else {
        gambar = Image.asset('assets/img/ceklis.png');
        judul = Text("PESANANMU SUDAH SAMPAI");
        subtitle = Text("");
        waktu = SizedBox(height: 0);
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
                height: 50,
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
              FontAwesomeIcons.moneyCheck,
              color: cokelat,
              size: 20,
            )
          : (status == 1)
              ? Icon(
                  FontAwesomeIcons.shop,
                  color: cokelat,
                  size: 20,
                )
              : (status == 2)
                  ? Icon(
                      FontAwesomeIcons.truckArrowRight,
                      color: cokelat,
                      size: 20,
                    )
                  : Icon(
                      FontAwesomeIcons.boxOpen,
                      color: cokelat,
                      size: 20,
                    );
    }

    Widget tick(bool isChecked, int status) {
      return isChecked
          ? Column(
              children: [
                SizedBox(
                  height: 30,
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
                  height: 30,
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
                height: 30,
              ),
              Container(
                color: Colors.amber,
                height: 2.0,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ])
          : Column(children: [
              SizedBox(
                height: 30,
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
        // color: kuning,
        padding: EdgeInsets.only(top: 10, bottom: 10),
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

    Future timelineDelivery(int indexnya) {
      return showModalBottomSheet(
        constraints: BoxConstraints(
          minHeight: 100.0,
          maxHeight: 400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        context: context,
        builder: ((context) {
          return Container(
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
                gambarTimeline(indexnya),
                data3(indexnya),
              ],
            ),
          );
        }),
      );
    }

    Widget statusTrx(int indexnya) {
      return Obx(
        () => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.statusOrder.value,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
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
                        // timelineDelivery(indexnya);
                        visibelDetDeli.value = !visibelDetDeli.value;
                      },
                      child: Row(
                        children: [
                          Text(
                            "Lihat Detail",
                            style: TextStyle(color: cokelat),
                          ),
                          Container(
                            child: (visibelDetDeli.isFalse)
                                ? Icon(Icons.keyboard_arrow_right,
                                    color: cokelat)
                                : Icon(Icons.keyboard_arrow_down_sharp,
                                    color: cokelat),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: visibelDetDeli.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 1,
                      width: lebarLayar,
                      // color: Colors.grey[200],
                    ),
                    gambarTimeline(indexnya),
                    data3(indexnya),
                  ],
                ),
              ),
            ],
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
              statusTrx(indexnya.value),

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
                            child: Text(
                              "INV-${controller.orderId}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        alignment: Alignment.centerRight),
                                    onPressed: () {
                                      Get.toNamed(Routes.INVOICE,
                                          arguments: "${controller.orderId}");
                                    },
                                    child: Text("Lihat Invoice"),
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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 25,
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.topLeft,
              child: Text(
                'Detail Belanja',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: cokelat,
                ),
              ),
            ),
            for (var i = 0; i < orderI.length; i++)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
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
                          // style: TextStyle(fontWeight: FontWeight.bold),
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
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                //no resi
                // Container(
                //   // color: Colors.pink,
                //   margin: EdgeInsets.symmetric(vertical: 5),
                //   child: Row(
                //     children: [
                //       Container(
                //         width: 150,
                //         child: Text('No. Resi'),
                //       ),
                //       Expanded(
                //         child: Text(
                //           "123456789",
                //           style: TextStyle(fontWeight: FontWeight.bold),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
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
                        child: Row(
                          children: [
                            Text('Alamat '),
                            Icon(
                              FontAwesomeIcons.addressCard,
                              size: 12,
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderShip['ship_fname'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w600),
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
                              (orderShip['ship_address'].toString().isEmpty)
                                  ? SizedBox(height: 0)
                                  : Text(
                                      orderShip['ship_address'].toString(),
                                      style: TextStyle(
                                          // fontSize: 12,
                                          ),
                                    ),
                              (orderShip['ship_address2'].toString().isEmpty)
                                  ? SizedBox(height: 0)
                                  : Text(
                                      orderShip['ship_address2'].toString(),
                                      style: TextStyle(
                                          // fontSize: 12,
                                          ),
                                    ),
                            ],
                          ),
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
                    height: 40,
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
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
