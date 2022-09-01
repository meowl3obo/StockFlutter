import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/widget/faq/global_ui.dart';
import 'package:flutter_application/widget/global/global.dart';
import 'package:flutter_application/widget/global/header.dart';
import 'package:flutter_application/widget/global/sidebar.dart';

class FAQMainPage extends StatelessWidget {
  const FAQMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String routePath;
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    var children = RouteData.of(context).pendingChildren;
    routePath = children.isNotEmpty ? children[0].path : "";

    return Scaffold(
      key: scaffoldKey,
      appBar: const Header(),
      drawer: Sidebar(scaffoldKey: scaffoldKey, parentContext: context),
      body: Column(
        children: <Widget>[
          if (routePath != '') ...[
            const WPrePage(),
            const Hr()
          ],
          const Expanded(
            child: AutoRouter(),
          )
        ],
      ),
      backgroundColor: rootColor['bgColor'],
    );
  }
}
