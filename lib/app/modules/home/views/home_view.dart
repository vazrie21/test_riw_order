import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:test_riw_order/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  final appName = 'Custom Themes';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        // accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('title'),
        ),
        body: Obx(
          () {
            late Map<String, dynamic> deviceData = controller.AdeviceData;
            return ListView(
              children: deviceData.keys.map(
                (String property) {
                  return Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          property,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        child: Text(
                          '${deviceData[property]}',
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                    ],
                  );
                },
              ).toList(),
            );
          },
        ),
        floatingActionButton: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(secondary: Colors.blueGrey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Get.toNamed(Routes.RIWAYAT_ORDER);
                },
                child: Icon(Icons.history),
              ),
              SizedBox(width: 50),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  Get.toNamed(Routes.CHECKOUT);
                },
                child: Icon(Icons.paypal_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
