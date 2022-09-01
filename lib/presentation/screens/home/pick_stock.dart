import 'package:flutter/material.dart';
import 'package:flutter_application/application/test/bloc.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_application/widget/global/header.dart';
import 'package:flutter_application/widget/global/sidebar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickStockPage extends StatelessWidget  {
  const PickStockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TestBloc(),
      child: const PickStockBody(),
    );
  }
}

class PickStockBody extends StatelessWidget {
  const PickStockBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final testBloc = BlocProvider.of<TestBloc>(context);
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello Flutter!',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Hello Flutter!',
                style: Theme.of(context).textTheme.headline2,
              ),
              Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 226, 209, 55),
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  transform: Matrix4.rotationZ(0.5),
                  height: 150,
                  child: const Text('我是Container，我有背景顏色',
                      style:
                          TextStyle(color: Color.fromARGB(255, 230, 55, 142)))),
              Center(
                child: BlocBuilder<TestBloc, TestState>(builder: (context, state) {
                  return Text("目前數值${state.count}");
                }),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Text("帳號：${state.account == '' ? '空的' : state.account}");
                }),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Text("信箱：${state.email == '' ? '空的' : state.email}");
                }),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Text("Token：${state.token == '' ? '空的' : state.token}");
                }),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Text("等級：${state.rank}");
                }),
              ),
              TextButton(
                onPressed: () {
                  testBloc.add(AddEvent());
                },
                child: const Text("加加")
              ),
              TextButton(
                onPressed: () {
                  testBloc.add(MinusEvent());
                },
                child: const Text("減減")
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toPath(context, '/test');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '聊天室'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: '個人資料'),
        ],
        fixedColor: Colors.amber, //選擇頁顏色
      ),
      drawer: Sidebar(scaffoldKey: scaffoldKey, parentContext: context),
    );
  }
}