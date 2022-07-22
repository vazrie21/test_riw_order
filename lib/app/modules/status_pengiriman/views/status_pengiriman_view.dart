import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:timeline_tile/timeline_tile.dart';
import 'package:progress_timeline/progress_timeline.dart';
import 'package:timelines/timelines.dart';
import '../controllers/status_pengiriman_controller.dart';

class StatusPengirimanView extends GetView<StatusPengirimanController> {
  const StatusPengirimanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dummyList = List<int>.generate(3, (index) => index);
    final tinggiAll = MediaQuery.of(context).size.height;
    final lebar = MediaQuery.of(context).size.width;
    final myAppBar = AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      title: Text(
        'StatusPengirimanView',
        style: TextStyle(
          color: Colors.black87,
        ),
      ),
    );
    final tinggi = tinggiAll -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final cokelat = Colors.brown.shade700;

    var dataDelivery = {}.obs;
    dataDelivery = controller.dataReq;

    Widget data3(int indexnya) {
      var gambar = ''.obs;
      var judul;
      var subtitle;
      var waktu;
      if (indexnya == 1) {
        gambar.value = 'assets/img/kado.png';
        judul = Text("PESANANMU SEDANG DI PROSES DI OUTLET TERDEKAT");
        subtitle = SizedBox(height: 0);
        waktu = SizedBox(height: 0);
      } else if (indexnya == 2) {
        gambar.value = 'assets/img/searching.png';
        judul = Text("MENCARI DRIVER TERDEKAT");
        subtitle = SizedBox(height: 0);
        waktu = SizedBox(height: 0);
      } else if (indexnya == 3) {
        gambar.value = 'assets/img/grab_delivery.png';
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
      } else if (indexnya == 4) {
        gambar.value = 'assets/img/grab_delivery.png';
        judul = Text("PESANANMU DALAM PERJALANAN");
        subtitle = Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dataDelivery.isNotEmpty
                  ? Text(
                      "Diantar oleh : ${dataDelivery['driver']['name'].toString()} - ${dataDelivery['driver']['phone'].toString()} ")
                  : Text(''),
              Icon(Icons.phone_iphone, size: 15, color: cokelat),
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
                      "Perkiraan waktu tiba : ${dataDelivery['timeline']['dropoff']} ")
                  : Text(''),
              Icon(Icons.access_time_rounded, size: 15, color: cokelat),
            ],
          ),
        );
      } else {
        gambar.value = 'assets/img/ceklis.png';
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

      return Obx(() {
        return Container(
          padding: EdgeInsets.only(bottom: 20),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: [
                //gambar
                SizedBox(
                  height: 100,
                  child: Image.asset(gambar.value),
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
      });
    }

    // Widget dataTimeline1(indexnya) {
    //   return Obx(() {
    //     return Container(
    //       height: 150,
    //       alignment: Alignment.topCenter,
    //       width: MediaQuery.of(context).size.width,
    //       child: Timeline.tileBuilder(
    //         // padding: EdgeInsets.all(5),
    //         theme: TimelineThemeData(
    //           connectorTheme:
    //               ConnectorThemeData(color: Colors.amber, thickness: 2),
    //           indicatorTheme: IndicatorThemeData(color: cokelat),
    //           nodeItemOverlap: false,
    //           direction: Axis.horizontal,
    //         ),
    //         builder: TimelineTileBuilder.connectedFromStyle(
    //           itemCount: 4,
    //           firstConnectorStyle: ConnectorStyle.transparent,
    //           lastConnectorStyle: ConnectorStyle.transparent,
    //           connectionDirection: ConnectionDirection.before,
    //           contentsAlign: ContentsAlign.reverse,
    //           contentsBuilder: (context, index) => Container(
    //             padding: EdgeInsets.all(24.0),
    //             child: index == 0
    //                 ? Icon(Icons.shopify_rounded)
    //                 : index == 1
    //                     ? Icon(Icons.map_outlined)
    //                     : index == 2
    //                         ? Icon(Icons.delivery_dining_outlined)
    //                         : index == 3
    //                             ? Icon(Icons.home_outlined)
    //                             : Text(""),
    //           ),
    //           oppositeContentsBuilder: ((context, index) => Text('data')),
    //           connectorStyleBuilder: (context, index) {
    //             return (index >= 2)
    //                 ? ConnectorStyle.dashedLine
    //                 : ConnectorStyle.solidLine;
    //           },
    //           indicatorStyleBuilder: (context, index) {
    //             return (index >= 2)
    //                 ? IndicatorStyle.outlined
    //                 : IndicatorStyle.dot;
    //           },
    //           itemExtent: (MediaQuery.of(context).size.width * 0.95) / 4,
    //           // itemExtentBuilder: (context, index) => index,
    //           // nodePositionBuilder: (context, index) => 5,
    //         ),
    //       ),
    //     );
    //   });
    // }

    Widget iconTick(int status) {
      return (status == 0)
          ? Icon(
              Icons.shopify_outlined,
              color: cokelat,
            )
          : (status == 1)
              ? Icon(
                  Icons.map_outlined,
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
              (status > 2)
                  ? (i < (status - 1))
                      ? Row(
                          children: (i == 0)
                              ? [tick(true, i)]
                              : [line(true), tick(true, i)])
                      : Row(
                          children: (i == 0)
                              ? [tick(false, i)]
                              : [line(false), tick(false, i)])
                  : (i < status)
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

    var indexnya = 0.obs;
    // indexnya = controller.indexStatus;
    indexnya.value = 4;
    return MaterialApp(
      home: Scaffold(
        appBar: myAppBar,
        body: Obx(
          () => indexnya > 0
              ? Column(
                  children: [
                    SizedBox(height: 5),
                    headerA(indexnya.value),
                    Card(
                      child: Column(
                        children: [
                          gambarTimeline(indexnya.value),
                          data3(indexnya.value),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(''),
                    ),
                  ],
                )
              : Container(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
