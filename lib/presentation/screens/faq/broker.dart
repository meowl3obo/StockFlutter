import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class BrokerFAQPage extends StatefulWidget {
  const BrokerFAQPage({Key? key}) : super(key: key);

   @override
   BrokerState createState() => BrokerState();
 }

 class BrokerState extends State<BrokerFAQPage> {
   @override
   void initState() {
     super.initState();
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }

   @override
   Widget build(BuildContext context) {
     return const WebView(
       initialUrl: 'https://stock.zbdigital.net/mDocs/brokerbuysell.html',
     );
   }
 }