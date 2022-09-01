import 'package:flutter/material.dart';
import 'package:flutter_application/application/broker/bloc.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/infrastructure/broker.dart';
import 'package:flutter_application/infrastructure/group.dart';
import 'package:flutter_application/infrastructure/stock.dart';
import 'package:flutter_application/application/stock/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'response.dart';

void getDefaultData(BuildContext context) {
  print("get default data");
  getTrandingDay(context);
  getAllStockMap(context);
  getIndustryList(context);
}

void getUserData(UserBloc userBloc, String token, String account, BuildContext context) {
  print("get user data");
  getGroup(context, token);
  getBroker(context, token);
  getAllBrokers(context, token);
}

void getTrandingDay(BuildContext context) async {
  var stockBloc = BlocProvider.of<StockBloc>(context);
  var res = await getLastTranding();

  if (res.code != 10000) {
    apiErrorAction(res.code, '取得最後更新日失敗', context);
  }

  var date = res.body!.replaceAll(RegExp(r'"'), "").replaceAll(RegExp(r'^20\d+-'), "");
  stockBloc.add(UpdateLastTradingEvent(date: date));
}

void getIndustryList(BuildContext context) async {
  var stockBloc = BlocProvider.of<StockBloc>(context);
  var res = await getIndustrys();
  if (res.code != 10000) {
    apiErrorAction(res.code, '取得行業別失敗', context);
  }
  stockBloc.add(UpdateIndustryEvent(industrys: res.body!));
}

void getAllStockMap(BuildContext context) async {
  var stockBloc = BlocProvider.of<StockBloc>(context);
  var res = await getAllStock();
  if (res.code != 10000) {
    apiErrorAction(res.code, '取得股票名稱失敗', context);
  }
  stockBloc.add(UpdateAllStockEvent(allStock: res.body!));
}

void getAllBrokers(BuildContext context, String token) async {
  Map<String, dynamic> query  = {
    "token": token,
  };
  var brokerBloc = BlocProvider.of<BrokerBloc>(context);
  var res = await getBrokerList(query);

  if (res.code != 10000) {
    apiErrorAction(res.code, '取得券商列表失敗', context);
  }

  brokerBloc.add(UpdateBrokersEvent(brokers: res.body!));
}

void getGroup(BuildContext context, String token) async {
  var userBloc = BlocProvider.of<UserBloc>(context);
  var res = await getUserGroup(token);

  if (res.code != 10000) {
    apiErrorAction(res.code, '取得自選股列表失敗', context);
  }
  userBloc.add(UpdateGroupEvent(group: res.body!));
}

void getBroker(BuildContext context, String token) async {
  var userBloc = BlocProvider.of<UserBloc>(context);
  var res = await getUserBroker(token);

  if (res.code != 10000) {
    apiErrorAction(res.code, '取得我的券商失敗', context);
  }

  userBloc.add(UpdateMyBrokersEvent(myBrokers: res.body!));
}