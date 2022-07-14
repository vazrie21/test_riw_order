import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_riw_order/app/routes/app_pages.dart';

import '../controllers/riwayat_order_controller.dart';

class RiwayatOrderView extends GetView<RiwayatOrderController> {
  const RiwayatOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tinggiLayar = MediaQuery.of(context).size.height;
    final lebarLayar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text('RiwayatOrderView'),
        centerTitle: true,
      ),
      body: Center(
        child: listOrder(context),
      ),
    );
  }

  Widget listOrder(BuildContext context) {
    List dataDummy = controller.orderList;
    final lebarLayar = MediaQuery.of(context).size.width;
    return Obx(() {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: dataDummy.length,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            itemBuilder: (context, index) {
              var order = dataDummy[index]['order'];
              var orderItem = dataDummy[index]['order_item'];
              var orderBilling = dataDummy[index]['order_billing'];
              var orderShipping = dataDummy[index]['order_shipping'];
              int qtyAllProd = 0;

              for (var i = 0; i < orderItem.length; i++) {
                qtyAllProd = qtyAllProd + int.parse(orderItem[i]['quantity']);
              }

              return InkWell(
                child: Column(
                  children: [
                    Container(
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    child: Text(order['order_id']),
                                  ),
                                ),
                                Container(
                                  child: Text(order['order_status']),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade200),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 100,
                                    child: Image.network(orderItem[0]['img'])),
                                Expanded(
                                  child: Container(
                                    child: ListTile(
                                      title:
                                          Text(orderItem[0]['product_title']),
                                      subtitle:
                                          Text(orderItem[0]['quantity'] + "X"),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 100,
                                    // color: Colors.amber,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(orderBilling['bill_status']),
                                        Text(orderBilling['payment_method'])
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(orderItem.length > 1
                                        ? "+${orderItem.length - 1} item lainya"
                                        : ""),
                                  ),
                                ),
                                Container(
                                  child: Text("Total Pesanan : "),
                                ),
                                Container(
                                  child: Text(
                                    CurrencyFormat.convertToIdr(
                                        int.parse(order['order_total']), 0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade200),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text("Lihat detail pesanan"),
                                  ),
                                ),
                                Container(
                                    child: Icon(Icons.chevron_right_sharp)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                onTap: () {
                  print("ini intdex ke : ${index}");
                  Get.toNamed(Routes.DETAIL_ORDER,
                      arguments: "${order['order_id']}");
                },
              );
            },
          ));
    });
  }
}
