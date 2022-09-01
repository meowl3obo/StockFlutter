import 'package:flutter/material.dart';
import 'package:flutter_application/library/auth/logout.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/infrastructure/broker.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String a = '';

  void _incrementChange(String val) {
    setState(() {
      a = val;
    });
  }

  String inputVal = '';
  final TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();   
    myController.text = inputVal;
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: myController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              onChanged: (String val) {
                inputVal = val;
              },
            ),
            TextButton(
              child: const Text("更新文字"),
              onPressed: () {
                _incrementChange(inputVal);
              },
            ),
            Text(a),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var a = await test(context);
          inputVal = a.toString();
          _incrementChange(inputVal);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Home'),
            onTap: () {
              toPath(context, '/');
            },
          ),
          ListTile(
            title: const Text('Test'),
            onTap: () {
              toPath(context, '/test');
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () { logout(context); },
          ),
        ],
      )),
    );
  }
}


Future<Map<String, List<dynamic>>> test(BuildContext context) async {
  final token = BlocProvider.of<AuthBloc>(context).state.token;
  Map<String, dynamic> query  = {
    "token": token,
  };
  var res = await getBrokerList(query);

  if (res.code != 10000) {
    apiErrorAction(res.code, '取得測試資料', context);
  }

  return res.body!;
}
