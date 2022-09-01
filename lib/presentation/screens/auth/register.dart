import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/infrastructure/auth.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/model/auth.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/widget/auth/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  String account = '';
  String mail = '';
  String password = '';
  String confirm = '';
  final TextEditingController accountController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void dispose() {
    accountController.dispose();
    mailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height - 520) / 2),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 520,
            decoration: BoxDecoration(
              color: rootColor['cardBg'],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: rootColor['cardShoadow']!, blurRadius: 5)
              ]
            ),
            child: Column(
              children: <Widget>[
                const WTitle(text: "註冊"),
                WLabelInput(controller: accountController, obscureText: false, text: "帳號", onChange: (String val) { account = val; }),
                WLabelInput(controller: mailController, obscureText: false, text: "電子信箱", onChange: (String val) { mail = val; }),
                WLabelInput(controller: passwordController, obscureText: true, text: "密碼", onChange: (String val) { password = val; }),
                WLabelInput(controller: confirmController, obscureText: true, text: "確認密碼", onChange: (String val) { confirm = val; }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 00),
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const WLabel(text: "您是舊用戶嗎？"),
                          TextButton(
                            onPressed: () {
                              toPath(context, '/login');
                            },
                            child: const Text("前往登入"),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: rootColor['lightButton'],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )
                        ),
                        onPressed: () async {
                          if (account == '' || mail == '' || password == '') {
                            print("輸入欄位不得為空");
                          } else if (password != confirm) {
                            print("確認密碼錯誤");
                          } else {
                            EasyLoading.show(status: 'loading...');
                            var res = await register(account, mail, password);
                            checkRes(context, res);
                          }
                        },
                        child: Text(
                          "註冊",
                          style: TextStyle(
                            color: rootColor['darkFont'],
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
      
      backgroundColor: rootColor["bgColor"], // #141c24
    );
  }
}

Future<ApiRes> register(String account, String mail, String password) async {
  TRegister body = TRegister(
    account: account,
    email: mail,
    password: password
  );

  var response = await registerApi(body);
  
  return response;
}

void checkRes(BuildContext context, ApiRes res) async {
  if (res.code == 10000) {
    toPath(context, "/login");
    showToast("註冊成功 請至E-mail收取驗證信", context, "success");
  } else {
    showToast("註冊失敗 ${res.message}", context, "error");
  }
  EasyLoading.dismiss();
}