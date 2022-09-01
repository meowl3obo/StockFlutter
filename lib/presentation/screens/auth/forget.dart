import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/infrastructure/auth.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/widget/auth/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgetPage extends StatelessWidget {
  String account = '';
  final TextEditingController accountController = TextEditingController();
  ForgetPage({Key? key}) : super(key: key);

  void dispose() {
    accountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 250,
          decoration: BoxDecoration(
            color: rootColor['cardBg'],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: rootColor['cardShoadow']!, blurRadius: 5
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              const WTitle(text: "忘記密碼"),
              WLabelInput(controller: accountController, obscureText: true, text: "帳號", onChange: (String val) { account = val; }),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 00),
                child: Row(
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
                        if (account == '') {
                          print("輸入欄位不得為空");
                        } else {
                          EasyLoading.show(status: 'loading...');
                          var res = await forgetRequest(account);
                          checkRes(context, res);
                        }
                      },
                      child: Text(
                        "送出",
                        style: TextStyle(
                          color: rootColor['darkFont'],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      backgroundColor: rootColor["bgColor"], // #141c24
    );
  }
}

Future<ApiRes> forgetRequest(String account) async {
  var response = await forgetApi(account);
  
  return response;
}

void checkRes(BuildContext context, ApiRes res) async {
  if (res.code == 10000) {
    toPath(context, "/login");
    showToast("請求成功 請至E-mail收取驗證信", context, "success");
  } else {
    showToast("請求失敗 ${res.message}", context, "error");
  }
  EasyLoading.dismiss();
}