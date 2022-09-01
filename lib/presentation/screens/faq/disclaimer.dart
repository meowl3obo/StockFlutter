import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class DisclaimerFAQPage extends StatefulWidget {
  const DisclaimerFAQPage({Key? key}) : super(key: key);

   @override
   DisclaimerState createState() => DisclaimerState();
 }

 class DisclaimerState extends State<DisclaimerFAQPage> {
   @override
   void initState() {
     super.initState();
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }

   @override
   Widget build(BuildContext context) {
     return const WebView(
       initialUrl: 'https://stock.zbdigital.net/mDocs/disclaimer.html',
     );
   }
 }