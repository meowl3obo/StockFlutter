import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class PickStockFAQPage extends StatefulWidget {
  const PickStockFAQPage({Key? key}) : super(key: key);

   @override
   PickStockState createState() => PickStockState();
 }

 class PickStockState extends State<PickStockFAQPage> {
   @override
   void initState() {
     super.initState();
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }

   @override
   Widget build(BuildContext context) {
     return const WebView(
       initialUrl: 'https://stock.zbdigital.net/mDocs/pickstock.html',
     );
   }
 }