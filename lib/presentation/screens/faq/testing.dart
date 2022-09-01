import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestingFAQPage extends StatefulWidget {
  const TestingFAQPage({Key? key}) : super(key: key);

  @override
  TestingState createState() => TestingState();
}

class TestingState extends State<TestingFAQPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'https://stock.zbdigital.net/mDocs/backtesting.html',
    );
  }
}
