import 'package:flutter/material.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/infrastructure/auth.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/library/global/data.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/model/auth.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/widget/auth/global.dart';
import 'package:flutter_application/widget/auth/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  String account = '';
  String password = '';
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({Key? key}) : super(key: key);

  void dispose() {
    accountController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height - 600) / 2),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 600,
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
                const WTitle(text: "登入"),
                WSocialBtn(
                    bgColor: const Color.fromARGB(255, 255, 255, 255),
                    callBack: () async {
                      EasyLoading.show(status: 'loading...');
                      var res = await googleLogin();
                      checkLoginRes(context, authBloc, res);
                    },
                    text: "使用Google登入",
                    color: const Color.fromARGB(255, 0, 0, 0),
                    img:
                        "http://pngimg.com/uploads/google/google_PNG19635.png"),
                WSocialBtn(
                    bgColor: const Color.fromARGB(255, 24, 119, 242),
                    callBack: () async {
                      EasyLoading.show(status: 'loading...');
                      var res = await facebookLogin();
                      checkLoginRes(context, authBloc, res);
                    },
                    text: "使用Facebook登入",
                    color: const Color.fromARGB(255, 255, 255, 255),
                    img:
                        "https://pngimg.com/uploads/facebook_logos/facebook_logos_PNG19754.png"),
                const WOrHr(text: "或"),
                WLabelInput(controller: accountController, obscureText: false, text: "帳號", onChange: (String val) { account = val; }),
                WLabelInput(controller: passwordController, obscureText: true, text: "密碼", onChange: (String val) { password = val; }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 00),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(status: 'loading...');
                        var res = await login(account, password);
                        checkLoginRes(context, authBloc, res);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: rootColor['lightButton'],
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                      child: Text(
                        "登入",
                        style: TextStyle(
                          color: rootColor['darkFont'],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const WLabel(text: "您是新用戶嗎？"),
                          TextButton(
                            onPressed: () {
                              toPath(context, '/register');
                            },
                            child: const Text("建立帳戶"),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          toPath(context, '/forget');
                        },
                        child: const Text("忘記密碼"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      backgroundColor: rootColor["bgColor"]
    );
  }
}

Future<ApiDataRes<LoginRes>> login(String account, String password) async {
  TLogin body = TLogin(
    account: account,
    password: password,
  );
  var response = await loginApi(body);
  
  return response;
}

void checkLoginRes(BuildContext context, AuthBloc authBloc, ApiDataRes<LoginRes> res) async {
  final userBloc = BlocProvider.of<UserBloc>(context);
  if (res.code == 10000) {
    final prefs = await SharedPreferences.getInstance();

    authBloc.add(UpdateAccountEvent(account: res.body!.account));
    authBloc.add(UpdateTokenEvent(token: res.body!.token));
    authBloc.add(UpdateEmailEvent(email: res.body!.email));
    authBloc.add(UpdateRankEvent(rank: res.body!.rank));
    await prefs.setBool("isLogin", true);
    await prefs.setString("account", res.body!.account);
    await prefs.setString("email", res.body!.email);
    await prefs.setString("token", res.body!.token);
    await prefs.setInt("rank", res.body!.rank);

    toPath(context, "/");
    getUserData(userBloc, res.body!.token, res.body!.account, context);
    showToast("登入成功", context, "success");
  } else {
    apiErrorAction(res.code, '登入失敗', context);
  }
  EasyLoading.dismiss();
}
