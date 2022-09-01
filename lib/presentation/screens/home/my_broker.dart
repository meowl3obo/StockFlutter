import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/application/broker/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/library/global/data.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_application/widget/global/header.dart';
import 'package:flutter_application/widget/global/sidebar.dart';
import 'package:flutter_application/widget/home/my_broker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class MyBrokerPage extends StatelessWidget {
//   const MyBrokerPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => BrokerBloc(),
//       child: MyBrokerBody(),
//     );
//   }
// }

class MyBrokerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKey');
    GlobalKey<BrokerSelectState> selectKey = GlobalKey<BrokerSelectState>(debugLabel: '_selectKey');
    GlobalKey<BrokerResultState> resultKey = GlobalKey<BrokerResultState>(debugLabel: '_resultKey');
    var token = BlocProvider.of<AuthBloc>(context).state.token;
    
    return  Scaffold(
      key: scaffoldKey,
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: rootColor['hr']!),
                      padding: const EdgeInsets.fromLTRB(3, 0, 3, 0)
                    ),
                    onPressed: () {
                      toPath(context, '/');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_left_rounded,
                          color: rootColor['mainFont'],
                          size: 24.0,
                        ),
                        Text(
                          '券商買賣超',
                          style: TextStyle(
                            color: rootColor['mainFont'],
                            fontSize: 16
                          )
                        )
                      ],
                    ),
                  ),
                ),
                BrokerSelect(
                  key: selectKey,
                  onChange: (data) {
                    resultKey.currentState?.updateResult(data);
                  }
                ),
                BrokerResult(
                  key: resultKey,
                  onChange: (data) {
                    selectKey.currentState?.updateUsed(data);
                  }
                ),
              ],
            ),
          )
        ),
      ),
      drawer: Sidebar(scaffoldKey: scaffoldKey, parentContext: context),
      backgroundColor: rootColor["bgColor"], // #141c24
    );
  }
}