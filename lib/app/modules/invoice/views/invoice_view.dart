import 'package:flutter/material.dart';
// import 'dart:async';
import 'package:get/get.dart';

import '../controllers/invoice_controller.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: Text(controller.url),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(controller.url.toString()),
        ),
      ),
    );
  }
}
