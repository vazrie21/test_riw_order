import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/status_pengiriman_controller.dart';

class StatusPengirimanView extends GetView<StatusPengirimanController> {
  const StatusPengirimanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StatusPengirimanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StatusPengirimanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
