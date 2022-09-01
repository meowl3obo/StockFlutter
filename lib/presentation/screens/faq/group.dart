import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class GroupFAQPage extends StatefulWidget {
  const GroupFAQPage({Key? key}) : super(key: key);

   @override
   GroupState createState() => GroupState();
 }

 class GroupState extends State<GroupFAQPage> {
   @override
   void initState() {
     super.initState();
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }

   @override
   Widget build(BuildContext context) {
     return const WebView(
       initialUrl: 'https://stock.zbdigital.net/mDocs/group.html',
     );
   }
 }