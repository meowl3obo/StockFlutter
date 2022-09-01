import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/widget/global/header.dart';
import 'package:flutter_application/widget/global/sidebar.dart';
import 'package:flutter_application/widget/user/connect_setting.dart';
import 'package:flutter_application/widget/user/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectSettingPage extends StatelessWidget {
  ConnectSettingPage({Key? key}) : super(key: key);
  late String token = '';

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKey');
    token = BlocProvider.of<AuthBloc>(context).state.token;

    return Scaffold(
      key: scaffoldKey,
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const WCardTitle(title: "接收方式設定"),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: rootColor['border']!)
                    ),
                    child: ConnectSetting(token: token),
                  ),
                const SizedBox(height: 10),
                const WCardTitle(title: "選擇訂閱策略"),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: rootColor['border']!)
                    ),
                    child: StrategySetting(token: token),
                  )
              ],
            )
          )
        ),
      ),
      drawer: Sidebar(scaffoldKey: scaffoldKey, parentContext: context),
      backgroundColor: rootColor["bgColor"], // #141c24
    );
  }
}