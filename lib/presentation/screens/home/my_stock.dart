import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/infrastructure/stock.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/model/stock.dart';
import 'package:flutter_application/widget/global/global.dart';
import 'package:flutter_application/widget/global/header.dart';
import 'package:flutter_application/widget/home/stock.dart';
import 'package:flutter_application/widget/home/my_stock.dart';
import 'package:flutter_application/widget/global/sidebar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyStockPage extends StatelessWidget {
  final GlobalKey<StockTableState> stockTableKey = GlobalKey<StockTableState>();
  final GlobalKey<ControlGroupState> controlGroupKey = GlobalKey<ControlGroupState>();
  late StockData sourceData = StockData.create();
  late int chooseGroup = -1;
  late String token = '';

  MyStockPage({Key? key}) : super(key: key);

  void getData(String token, List<String> codes, BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    sourceData = await getMyStocks(token, codes, context);
    stockTableKey.currentState!.updateStockData(sourceData);
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKey');
    token = BlocProvider.of<AuthBloc>(context).state.token;

    return Scaffold(
      key: scaffoldKey,
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ControlGroup(
                  key: controlGroupKey,
                ),
                BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                  if (chooseGroup > -1) {
                    var filter = state.group.singleWhere((i) => i.id == chooseGroup);
                    getData(token, filter.codes, context);
                  }
                  return ChooseGroup(
                    callBack: (List<String> item, int id) {
                      chooseGroup = id;
                      controlGroupKey.currentState!.updateChooseGroup(id);
                      getData(token, item, context);
                    },
                  );
                }),
                const PaddingHr(),
                StockTable(
                  key: stockTableKey,
                  isWarning: false,
                  data: sourceData
                ),
              ],
            )
        ),
      ),
      drawer: Sidebar(scaffoldKey: scaffoldKey, parentContext: context),
      backgroundColor: rootColor["bgColor"], // #141c24
    );
  }
}

StockData sortData(StockData socure, bool isReverse, String key) {
  if (isReverse) {
    socure.stockInfo.sort((a, b) => a.toMap()[key].compareTo(b.toMap()[key]));
  } else {
    socure.stockInfo.sort((a, b) => b.toMap()[key].compareTo(a.toMap()[key]));
  }
  StockData data = StockData(date: socure.date, stockInfo: socure.stockInfo);

  return data;
}

Future<StockData> getMyStocks(String token, List<String> codes, BuildContext context) async {
  var res = await getMultipleStock(token, codes);
  if (res.code != 10000) {
    apiErrorAction(res.code, '取得自選股資訊失敗', context);
  }
  return res.body!;
}

StockData searchData(StockData socure, bool notice, bool disposeOf, bool change, bool stop, bool termination) {
  List<StockInfo> stockInfo = [];
  for (var item in socure.stockInfo) { 
    if ((item.status == 1 && notice) || (item.status == 2 && disposeOf) || (item.status == 3 && change) || (item.status == 4 && stop) || (item.status == 5 && termination)) {
      stockInfo.add(item);
    }
  }
  StockData data = StockData(date: socure.date, stockInfo: stockInfo);

  return data;
}