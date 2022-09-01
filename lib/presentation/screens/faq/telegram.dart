import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class TelegramFAQPage extends StatefulWidget {
  const TelegramFAQPage({Key? key}) : super(key: key);

   @override
   TelegramState createState() => TelegramState();
 }

 class TelegramState extends State<TelegramFAQPage> {
   @override
   void initState() {
     super.initState();
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }

   @override
   Widget build(BuildContext context) {
     return const WebView(
       initialUrl: 'https://stock.zbdigital.net/mDocs/telegram.html',
     );
   }
 }