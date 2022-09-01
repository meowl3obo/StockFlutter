import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/infrastructure/stock.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/model/stock.dart';
import 'package:flutter_application/widget/global/checkbox.dart';
import 'package:flutter_application/widget/global/header.dart';
import 'package:flutter_application/widget/home/stock.dart';
import 'package:flutter_application/widget/global/sidebar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// class WarningPage extends StatefulWidget {
//   const WarningPage({Key? key}) : super(key: key);

//   @override
//   WarningBody createState() => WarningBody();
// }

class WarningPage extends StatelessWidget {
  bool notice = true;
  bool disposeOf = true;
  bool change = true;
  bool stop = true;
  bool termination = true;
  GlobalKey<CheckboxItemState> allKey = GlobalKey<CheckboxItemState>(debugLabel: '_allScreenkey');
  GlobalKey<CheckboxItemState> noticeKey = GlobalKey<CheckboxItemState>(debugLabel: '_noticeScreenkey');
  GlobalKey<CheckboxItemState> disposeOfKey = GlobalKey<CheckboxItemState>(debugLabel: '_disposeOfScreenkey');
  GlobalKey<CheckboxItemState> changeKey = GlobalKey<CheckboxItemState>(debugLabel: '_changeScreenkey');
  GlobalKey<CheckboxItemState> stopKey = GlobalKey<CheckboxItemState>(debugLabel: '_stopScreenkey');
  GlobalKey<CheckboxItemState> terminationKey = GlobalKey<CheckboxItemState>(debugLabel: '_terminationScreenkey');
  GlobalKey<StockTableState> stockTableKey = GlobalKey<StockTableState>();
  late StockData sourceData = StockData(date: "", stockInfo: []);
  late StockData data = StockData(date: "", stockInfo: []);
  String nowSort = '';
  
  void setData(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    sourceData = await getWarning(context);
    data = searchData(sourceData, notice, disposeOf, change, stop, termination);
    stockTableKey.currentState!.updateStockData(data);
    EasyLoading.dismiss();
  }

  void reSearchData() {
    data = searchData(sourceData, notice, disposeOf, change, stop, termination);
    stockTableKey.currentState!.updateStockData(data);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKey');
    setData(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: rootColor['hr']!),
                  ),
                  onPressed: () => showDialog(
                    barrierColor: rootColor['backdrop'],
                    context: context,
                    builder:  (BuildContext context) => AlertDialog(
                      backgroundColor: rootColor['cardBg'],
                      content: SizedBox(
                        height: 275,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              CheckboxItem(
                                key: allKey, 
                                title: "全選", 
                                value: notice && disposeOf && change && stop && termination, 
                                onChange: (status) {
                                  bool newStatus = (notice && disposeOf && change && stop && termination);
                                  notice = !newStatus;
                                  disposeOf = !newStatus;
                                  change = !newStatus;
                                  stop = !newStatus;
                                  termination = !newStatus;
                                  noticeKey.currentState?.setValue(notice);
                                  disposeOfKey.currentState?.setValue(disposeOf);
                                  changeKey.currentState?.setValue(change);
                                  stopKey.currentState?.setValue(stop);
                                  terminationKey.currentState?.setValue(termination);
                                  reSearchData();
                                },
                              ),
                              CheckboxItem(
                                key: noticeKey, 
                                title: "注意股", 
                                value: notice, 
                                onChange: (status) {
                                  notice = status; 
                                  allKey.currentState?.setValue(notice && disposeOf && change && stop && termination);
                                  reSearchData();
                                }
                              ),
                              CheckboxItem(
                                key: disposeOfKey, 
                                title: "處置股", 
                                value: disposeOf, 
                                onChange: (status) {
                                  disposeOf = status; 
                                  allKey.currentState?.setValue(notice && disposeOf && change && stop && termination);
                                  reSearchData();
                                }
                              ),
                              CheckboxItem(
                                key: changeKey, 
                                title: "變更交易", 
                                value: change, 
                                onChange: (status) {
                                  change = status; 
                                  allKey.currentState?.setValue(notice && disposeOf && change && stop && termination);
                                  reSearchData();
                                }
                              ),
                              CheckboxItem(
                                key: stopKey, 
                                title: "停止買賣", 
                                value: stop, 
                                onChange: (status) {
                                  stop = status; 
                                  allKey.currentState?.setValue(notice && disposeOf && change && stop && termination);
                                  reSearchData();
                                }
                              ),
                              CheckboxItem(
                                key: terminationKey, 
                                title: "終止交易", 
                                value: termination, 
                                onChange: (status) {
                                  termination = status; 
                                  allKey.currentState?.setValue(notice && disposeOf && change && stop && termination);
                                  reSearchData();
                                }
                              ),
                            ],
                          ),
                        )
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text(
                            '關閉',
                            style: TextStyle(
                              color: rootColor['mainFont'],
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "---- 警示股 ----",
                          style: TextStyle(
                            color: rootColor['mainFont'],
                            fontSize: 16
                          ),
                        )
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: rootColor['mainFont'],
                          size: 20.0,
                        ),
                      )
                    ],
                  )
                ),
              ),
              StockTable(
                key: stockTableKey,
                isWarning: true,
                data: data
              ),
            ],
          ),
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

Future<StockData> getWarning(BuildContext context) async {
  var res = await getWarningStock();
  if (res.code != 10000) {
    apiErrorAction(res.code, '取得警示股失敗', context);
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