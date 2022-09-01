import 'package:flutter/material.dart';
import 'package:flutter_application/application/broker/bloc.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/library/global/data.dart';
import 'package:flutter_application/presentation/router/main.gr.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/application/stock/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/presentation/router/guards.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final AppRouter appRouter = AppRouter(authGuard: AuthGuard());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => StockBloc(),),
        BlocProvider(create: (BuildContext context) => AuthBloc(),),
        BlocProvider(create: (BuildContext context) => UserBloc(),),
        BlocProvider(create: (BuildContext context) => BrokerBloc(),),
      ],
      child: MyApp(appRouter: appRouter)
    )
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter;
  const MyApp({Key? key, required AppRouter appRouter}) : _appRouter = appRouter, super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    checkLogin(authBloc, userBloc, context);
    getDefaultData(context);

    return MaterialApp.router(
      builder: EasyLoading.init(),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

void checkLogin(AuthBloc authBloc, UserBloc userBloc, BuildContext context) async {
  print("check login");
  final token = BlocProvider.of<AuthBloc>(context).state.token;
  final account = BlocProvider.of<AuthBloc>(context).state.account;
  final prefs = await SharedPreferences.getInstance();
  var isLogin = prefs.getBool("isLogin");

  if (isLogin != null && isLogin) {
    if (token == '' || account == '') {
      authBloc.add(UpdateAccountEvent(account: prefs.getString("account") ?? ''));
      authBloc.add(UpdateTokenEvent(token: prefs.getString("token") ?? ''));
      authBloc.add(UpdateEmailEvent(email: prefs.getString("email") ?? ''));
      authBloc.add(UpdateRankEvent(rank: prefs.getInt("rank") ?? 0));
    }
    getUserData(userBloc, prefs.getString("token") ?? '', prefs.getString("account") ?? '', context);
  }
}