// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

var adrCust = [].obs;
var adrDef = {}.obs;
var cartA = [].obs;
var lebarLayar;

var allOutlet = [].obs;
var outletTerdekat = [].obs;
var allArea = [].obs;

final cokelat = Colors.brown.shade700;
final kuning = Colors.amber;
final putih = Colors.white;
final hBtipis = TextStyle(fontSize: 18);
final hBtebal = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

class CheckoutView extends GetView<CheckoutController> {
  CheckoutView({Key? key}) : super(key: key);

  Widget alamatDel(BuildContext context) {
    return Container(
      // height: 100,
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(width: 20, child: Icon(Icons.location_pin, color: kuning)),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Address'),
                  SizedBox(height: 7),
                  Text('Rumah 1 | 081234567895'),
                  Container(
                    child: Text(
                        'data loren mpdum lorenipsum lo renip data loren mpdum lorenipsum lo renip data loren mpdum lorenipsum lo renip'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(child: Icon(Icons.chevron_right_outlined)),
        ],
      ),
    );
  }

  Widget pilihOutlet(BuildContext context) {
    final tinggiLayar = MediaQuery.of(context).size.height;
    lebarLayar = MediaQuery.of(context).size.width;
    allOutlet = controller.allOutlet;
    outletTerdekat = controller.outletTerdekat;
    allArea = controller.allArea;

    return Container(
      height: 100,
      width: lebarLayar,
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Center(child: Text('Pilih Outlet', style: hBtebal)),
              content: Container(
                width: lebarLayar,
                height: tinggiLayar * 0.6,
                child: ListView.builder(
                  itemCount: allOutlet.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text(allOutlet[index]['nama']),
                      subtitle: Text(
                        " ${allOutlet[index]['address']} - ${allOutlet[index]['city']}",
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      onTap: () {
                        controller.outletTerpilih.value = allOutlet[index];
                        print(controller.outletTerpilih);
                        Navigator.pop(context, true);
                      },
                    );
                  }),
                ),
              ),
            ),
          );
        },
        child: Container(
          child: Row(
            children: [
              Container(
                width: lebarLayar * 0.2,
                child: Icon(
                  Icons.store,
                  color: kuning,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: controller.outletTerpilih.isEmpty
                      ? Text(
                          'PILIH OUTLET',
                          style: TextStyle(color: cokelat, fontSize: 18),
                        )
                      : Text(
                          controller.outletTerpilih['nama'],
                          style: TextStyle(color: cokelat, fontSize: 18),
                        ),
                ),
              ),
              Container(
                width: lebarLayar * 0.2,
                child: Icon(
                  Icons.arrow_right,
                  color: cokelat,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget delAddres(BuildContext context) {
    final tinggiLayar = MediaQuery.of(context).size.height;
    return Obx(
      () => Column(
        children: [
          // delivery / pickup
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
            ),
            height: tinggiLayar * 0.07,
            child: Row(
              children: [
                Container(
                  color: controller.isDelivery.isTrue ? kuning : putih,
                  height: tinggiLayar * 0.07,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: lebarLayar * 0.5,
                  child: TextButton(
                    onPressed: () {
                      controller.isDelivery.value = true;
                    },
                    child: Text(
                      'DELIVERY',
                      style: TextStyle(color: cokelat),
                    ),
                  ),
                ),
                Container(
                  color: controller.isDelivery.isFalse ? kuning : putih,
                  height: tinggiLayar * 0.07,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: lebarLayar * 0.5,
                  child: TextButton(
                    onPressed: () {
                      controller.isDelivery.value = false;
                    },
                    child: Text(
                      'PICK-UP',
                      style: TextStyle(color: cokelat),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //deladr
          controller.isDelivery.isTrue
              ? alamatDel(context)
              : pilihOutlet(context),
        ],
      ),
    );
  }

  Widget itemCart(BuildContext context) {
    var orderI = controller.cartA;
    String varian = "";
    final lebarLayar = MediaQuery.of(context).size.width;
    // return Obx(() {
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
                        child: Image.network(orderI[i]['img'].toString()),
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
                                  orderI[i]['variant_1']!.isEmpty
                                      ? orderI[i]['product_title'].toString()
                                      : orderI[i]['product_title'].toString() +
                                          ' - ' +
                                          orderI[i]['variant_1'].toString(),
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                  // height: 15,
                                  child: Text(orderI[i]['quantity']! + " X")),
                              Text(CurrencyFormat.convertToIdr(
                                  int.parse(orderI[i]['price']!), 0)),
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
                                  int.parse(orderI[i]['quantity']!) *
                                      int.parse(
                                        orderI[i]['price']!,
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
    // });
  }

  Widget promoNpoin(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Container(
            child: Row(
              children: [
                Expanded(child: Text('Promo', style: hBtipis)),
                Container(child: Icon(Icons.chevron_right))
              ],
            ),
          ),
          Container(
              width: lebarLayar,
              height: 1,
              margin: EdgeInsets.only(top: 10),
              color: Colors.grey[200]),
          Container(
              child: Row(
            children: [
              Expanded(child: Text('Poin', style: hBtebal)),
              (controller.pointC.value != 0)
                  ? Container(
                      child: Text(
                      "- ${CurrencyFormat.convertToIdr(controller.pointC.value, 0)}",
                      style: TextStyle(color: controller.pakePoin.value),
                    ))
                  : SizedBox(width: 0),
              Switch(
                value: controller.isPoint.value,
                onChanged: (value) {
                  (value == true)
                      ? controller.pakePoin.value = cokelat
                      : controller.pakePoin.value = Colors.grey[400];
                  controller.isPoint.value = value;
                  print(controller.isPoint);
                },
                activeTrackColor: kuning,
                activeColor: cokelat,
              ),
            ],
          )),
        ]),
      ),
    );
  }

  Widget MetodeBayar(BuildContext context) {
    final tinggiLayar = MediaQuery.of(context).size.height;
    lebarLayar = MediaQuery.of(context).size.width;
    allOutlet = controller.allOutlet;
    outletTerdekat = controller.outletTerdekat;
    allArea = controller.allArea;

    return Container(
      // height: 100,
      width: lebarLayar,
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Center(child: Text('Pilih Outlet', style: hBtebal)),
              content: Container(
                width: lebarLayar,
                height: tinggiLayar * 0.6,
                child: ListView.builder(
                  itemCount: allOutlet.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text(allOutlet[index]['nama']),
                      subtitle: Text(
                        " ${allOutlet[index]['address']} - ${allOutlet[index]['city']}",
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      onTap: () {
                        controller.outletTerpilih.value = allOutlet[index];
                        print(controller.outletTerpilih);
                        Navigator.pop(context, true);
                      },
                    );
                  }),
                ),
              ),
            ),
          );
        },
        child: Container(
          child: Row(
            children: [
              // Container(
              //   width: lebarLayar * 0.2,
              //   child: Icon(
              //     Icons.store,
              //     color: kuning,
              //   ),
              // ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: controller.metodeBayar.isEmpty
                      ? Text(
                          'PILIH METODE PEMBAYARAN',
                          style: TextStyle(color: cokelat),
                        )
                      : Text(
                          controller.metodeBayar['nama'],
                          style: TextStyle(color: cokelat),
                        ),
                ),
              ),
              Container(
                width: lebarLayar * 0.2,
                child: Icon(
                  Icons.arrow_right,
                  color: cokelat,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rincianPembayaran(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Row(children: [
              Icon(Icons.list_alt_outlined),
              Expanded(child: Text(' Rincian Pembayaran', style: hBtipis)),
            ]),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Text('Total Harga')),
                Container(
                  child: Text(CurrencyFormat.convertToIdr(50000, 0)),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: Text('Ongkos Kirim')),
                Container(
                  child: Text(CurrencyFormat.convertToIdr(50000, 0)),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: Text('Promo')),
                Container(
                  child: Text(CurrencyFormat.convertToIdr(50000, 0)),
                )
              ],
            ),
            Container(
              height: 1,
              width: lebarLayar,
              margin: EdgeInsets.symmetric(vertical: 5),
              color: Colors.grey[200],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Total',
                  style: hBtipis,
                )),
                Container(
                  child: Text(
                    CurrencyFormat.convertToIdr(50000, 0),
                    style: hBtipis,
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    adrCust = controller.adrCust;
    adrDef = controller.adrDef;
    cartA.value = controller.cartA;

    lebarLayar = MediaQuery.of(context).size.width;

    final tinggiFull = MediaQuery.of(context).size.height;
    var appbar = AppBar(
      backgroundColor: cokelat,
      title: Text(
        'CheckoutView',
        style: TextStyle(color: kuning),
      ),
    );

    final tinggiLayar = tinggiFull -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appbar,
      body: Column(children: [
        Container(
          height: tinggiLayar * 0.93,
          child: ListView(
            children: [
              delAddres(context),
              itemCart(context),
              promoNpoin(context),
              MetodeBayar(context),
              rincianPembayaran(context),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            boxShadow: [],
          ),
          height: tinggiLayar * 0.07,
          child: Row(children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: lebarLayar * 0.65,
                // alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total Pembayarn'),
                    SizedBox(height: 6),
                    Text(CurrencyFormat.convertToIdr(100000, 0),
                        style: hBtebal),
                  ],
                )),
            Container(
                width: lebarLayar * 0.35,
                height: tinggiLayar * 0.10,
                color: cokelat,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Buat Pesanan',
                      style: TextStyle(color: kuning, fontSize: 18),
                    ))),
          ]),
        ),
      ]),
    );
  }
}
