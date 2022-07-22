import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class StatusPengirimanController extends GetxController {
  var curStep = 3.obs;
  var complet = false.obs;

  var dataDel = {}.obs;
  // ignore: prefer_typing_uninitialized_variables
  var timelineDel;
  var statusDel = ''.obs;
  var indexStatus = 0.obs;
  var dataReq = {}.obs;

  Future<void> olahData() async {
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
    olahData();
    // print(timelineDel['create']);
  }
}
