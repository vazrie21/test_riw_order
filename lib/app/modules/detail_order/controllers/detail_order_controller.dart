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
      statusOrder.value = "Order Diperoses";
      if (orderD["bill_statusx"] == "Pending") {
        statusOrder.value = "Menunggu Pembayaran";
      } else {
        if (orderD['ship_statusx'] != "Pending") {
          statusOrder.value = orderD['ship_statusx'];
        }
      }
    } else {
      statusOrder.value = "Dibatalkan";
    }
    print(statusOrder);
  }

  var curStep = 3.obs;
  var complet = false.obs;

  var dataDel = {}.obs;
  // ignore: prefer_typing_uninitialized_variables
  var timelineDel;
  var statusDel = ''.obs;
  var indexStatus = 0.obs;
  var dataReq = {}.obs;

  Future<void> dataStatusOrder() async {
    dataReq.value = {
      "deliveryID": "IN-2-00D2B1CBMWBO7JND48J5",
      "merchantOrderID": "053e68b3-bcbf-4493-b270-afac9c923169",
      "paymentMethod": "CASH",
      "quote": {
        "service": {"id": 0, "type": "INSTANT", "name": "GrabExpress"},
        "currency": {"code": "VND", "symbol": "₫", "exponent": 0},
        "amount": 29000,
        "estimatedTimeline": null,
        "distance": 5672,
        "origin": {
          "address": "1 IJK View, Singapore 018936",
          "keywords": "PQR Tower",
          "coordinates": {"latitude": 1.2345678, "longitude": 3.4567890}
        },
        "destination": {
          "address": "1 ABC St, Singapore 078881",
          "keywords": "XYZ Tower",
          "coordinates": {"latitude": 1.2345876, "longitude": 3.4567098}
        },
        "packages": [
          {
            "name": "Bún bò Huế - Bát nhỏ",
            "description": "Bát nhỏ. Nước trong nhé Quán",
            "quantity": 2,
            "price": 28000,
            "dimensions": {"weight": 1},
            "currency": {"code": "VND", "symbol": "₫", "exponent": 0}
          },
          {
            "name": "Bún bò Huế - Bát lớn",
            "description": "Bát lớn. Nước trong nha, nhiều hành",
            "quantity": 1,
            "price": 36000,
            "dimensions": {"weight": 1},
            "currency": {"code": "VND", "symbol": "₫", "exponent": 0}
          }
        ]
      },
      "sender": {
        "firstName": "Nguyễn Anh Nguyên",
        "phone": "0901232468",
        "smsEnabled": true,
        "instruction":
            "Đến bấm chuông \n\n--- # TIỀN CẦN ỨNG CHO NHÀ HÀNG: 86,250\n"
      },
      "recipient": {
        "firstName": "Nguyễn Anh Nguyên",
        "phone": "0901232468",
        "smsEnabled": true,
        "instruction": "Chó dữ \n\n--- THU HỘ TỪ NGƯỜI MUA: 121,000\n"
      },
      "status": "COMPLETED",
      "trackingURL": "",
      "courier": null,
      "driver": {
        "name": "Johanan",
        "phone": "6288822666888",
        "licensePlate": "A 3333 SYY",
        "photoURL": "https://somephotourl.com/sgdfb6gfd87",
        "currentLat": 1.2345678,
        "currentLng": 3.4567890
      },
      "timeline": {
        "create": "2020-04-03T05:26:36Z",
        "allocate": "2020-04-03T05:33:03Z",
        "pickup": "2020-04-03T07:22:40Z",
        "dropoff": "2020-04-03T09:48:52Z",
        "completed": "2020-04-03T09:58:52Z"
      },
      "schedule": null,
      "cashOnDelivery": {"enable": true, "amount": 121000},
      "invoiceNo": "053e68b3-bcbf-4493-b270-afac9c923169",
      "pickupPin": "9092",
      "advanceInfo": {"failedReason": "6|Could not find driver"},
    };
    statusDel.value = dataReq['status'] as String;
    timelineDel = dataReq['timeline'];

    timelineDel.forEach((final String key, final value) {
      // print(key);
      timelineDel[key] = Jiffy(timelineDel[key]).format("dd MMM, HH:mm");
    });

    print(statusDel);
    print(timelineDel);

    indexStatus.value = statusDel == 'COMPLETED' || statusDel == 'DROPOFF'
        ? 5
        : statusDel == 'PICKUP'
            ? 4
            : statusDel == 'ALLOCATE'
                ? 3
                : statusDel == 'ALLOCATE'
                    ? 2
                    : 1;

    print(indexStatus);
  }

  @override
  void onReady() {
    super.onReady();
    dataOrder();
    dataStatusOrder();
  }
}
