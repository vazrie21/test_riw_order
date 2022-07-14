import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
      home: myHOmePage(context),
    );
  }
}

Widget myHOmePage(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('title'),
    ),
    body: Center(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Text(
          'Text with a background color',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    ),
    floatingActionButton: Theme(
      data: Theme.of(context).copyWith(
        colorScheme:
            Theme.of(context).colorScheme.copyWith(secondary: Colors.blueGrey),
      ),
      child: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.RIWAYAT_ORDER);
        },
        child: Icon(Icons.add),
      ),
    ),
  );
}
