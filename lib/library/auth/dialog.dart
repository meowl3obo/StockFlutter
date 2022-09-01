import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/infrastructure/auth.dart';
import 'package:flutter_application/library/auth/logout.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/model/auth.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future showUpdatePWDDialog(BuildContext mainContext) async {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  var authBloc = BlocProvider.of<AuthBloc>(mainContext);
  late String password = '';
  late String confirm = '';
  late String account = authBloc.state.account;
  late String token = authBloc.state.token;
  return showDialog<String>(
    context: mainContext,
    barrierColor: rootColor['backdrop'],
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: rootColor['cardBg'],
      insetPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      // insetPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      titlePadding: const EdgeInsets.fromLTRB(25, 10, 25, 1),
      contentPadding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      actionsPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
      titleTextStyle: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 18,
      ),
      title: const Text("修改密碼"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(150, 0, 150, 0)),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "新密碼",
              )
            ),
            Center(
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: rootColor['lightBorder']!),
                  ),
                ),
                style: TextStyle(
                  color: rootColor['mainFont']
                ),
                controller: passwordController,
                onChanged: (val) { password = val; },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "確認密碼",
              )
            ),
            Center(
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: rootColor['lightBorder']!),
                  ),
                ),
                style: TextStyle(
                  color: rootColor['mainFont']
                ),
                controller: confirmController,
                onChanged: (val) { confirm = val; },
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            "取消",
            style: TextStyle(
              color: rootColor['danger'],
              fontSize: 16,
            )
          ),
        ),
        TextButton(
            onPressed: () async {
              if (password == confirm) {
                var res = await updatePWD(token, account, password);
                if (res.code == 10000) {
                  logout(context);
                  showToast('密碼修改成功，請重新登入', mainContext, 'success');
                  Navigator.pop(context, 'Cancel');
                } else {
                  showFlushbar(res.message, mainContext, 'error', '修改密碼失敗');
                }
              } else {
                showFlushbar("新密碼與確認密碼不符", mainContext, 'error', '修改密碼失敗');
              };
            },
            child: Text(
              "送出",
              style: TextStyle(
                color: rootColor['success'],
                fontSize: 16,
              )
            ),
          )
      ]
    )
  );
}

Future<ApiRes> updatePWD(String token, String account, String password) async {
  TLogin body = TLogin(account: account, password: password);
  var res = await updatePWDApi(token, body);

  return res;
}