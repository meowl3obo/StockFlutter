import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class PrivacyFAQPage extends StatefulWidget {
  const PrivacyFAQPage({Key? key}) : super(key: key);

   @override
   PrivacyState createState() => PrivacyState();
 }

 class PrivacyState extends State<PrivacyFAQPage> {
   @override
   void initState() {
     super.initState();
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }

   @override
   Widget build(BuildContext context) {
     return const WebView(
       initialUrl: 'https://stock.zbdigital.net/mDocs/privacy.html',
     );
   }
 }