import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/infrastructure/broker.dart';
import 'package:flutter_application/library/global/data.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/library/group/dialog.dart';
import 'package:flutter_application/library/stock/dialog.dart';
import 'package:flutter_application/model/broker.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/widget/dialog/broker.dart';
import 'package:flutter_application/widget/global/collapse.dart';
import 'package:flutter_application/widget/global/global.dart';
import 'package:flutter_application/widget/home/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

Future showBrokerDialog(String code, String name, BuildContext mainContext) async {
  return showDialog<String>(
    context: mainContext,
    barrierColor: rootColor['backdrop'],
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: rootColor['cardBg'],
      insetPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      titlePadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
      title: titleBar(code, name, context, mainContext),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(mainContext).size.width,
          child: content(code, context),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            "關閉",
            style: TextStyle(
              color: rootColor['danger'],
              fontSize: 16,
            )
          ),
        )
      ]
    )
  );
}

Future showStoreBrokerDialog(Map<String, List<String>> resultBroker, BuildContext mainContext) {
  var token = BlocProvider.of<AuthBloc>(mainContext).state.token;
  final TextEditingController myBrokerNameController = TextEditingController();
  late String myBrokerName = '';
  return showDialog<String>(
    context: mainContext,
    barrierColor: rootColor['backdrop'],
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: rootColor['cardBg'],
      insetPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      titlePadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
      title: const Text("儲存我的券商"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            subTitle("我的券商名稱", " (輸入名稱，名稱重複則修改原設定)"),
            TextField(
              style: TextStyle(
                color: rootColor['mainFont'],
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: rootColor['lightBorder']!),
                ),
              ),
              controller: myBrokerNameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              onChanged: (String val) {
                myBrokerName = val;
              },
            ),
          ],
        )
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
            var res = await addMyBroker(token, myBrokerName, resultBroker);
            if (res.code == 10000) {
              getBroker(mainContext, token);
              Navigator.pop(context, 'Cancel');
              showFlushbar('我的券商$myBrokerName新增成功', mainContext, 'success', '新增我的券商成功');
            } else {
              showFlushbar(res.message, mainContext, 'error', '新增我的券商失敗');
            }
          },
          child: Text(
            "儲存",
            style: TextStyle(
              color: rootColor['Success'],
              fontSize: 16,
            )
          ),
        )
      ]
    )
  );
}

Widget titleBar(String code, String name, BuildContext context, BuildContext mainContext) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text("$name-$code"),
          const SizedBox(width: 5),
          BlocBuilder<UserBloc, UserState>(builder: (_, state) {
            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1.0, color: rootColor['hr']!),
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0)
              ),
              onPressed: () => {
                if (state.group.isEmpty) {
                  showFlushbar('請先至"自選股"頁面新增自選股群組', context, 'error', '新增自選股失敗')
                    } else {
                  showAddStockDialog(code, name, context, state.group)
                }
              },
              child: Text(
                "+自選股",
                style: TextStyle(
                  color: rootColor['mainFont']!,
                )
              ),
            );
          }),
        ]
      ),
      const SizedBox(width: 10),
      TextButton(
        onPressed: () { 
          showStockDialog(code, mainContext);
          Navigator.pop(context, 'Cancel'); 
        },
        child: Row(
          children: [
            Text(
              "股票資訊",
              style: TextStyle(
                color: rootColor['mainFont']!,
              )
            ),
            Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: rootColor['mainFont'],
              size: 24.0,
            ),
          ],
        ),
      )
    ],
  );
}

Widget content(String code, BuildContext context) {
  final GlobalKey<CollapseState> collapseDateKey = GlobalKey<CollapseState>();
  final GlobalKey<CollapseState> collapseBrokerKey = GlobalKey<CollapseState>();
  final GlobalKey<InOutContentState> contentKey = GlobalKey<InOutContentState>();
  final GlobalKey<ChangeButtonState> changeButtonKey = GlobalKey<ChangeButtonState>();
  final GlobalKey<DatePickerState> startDateKey = GlobalKey<DatePickerState>();
  final GlobalKey<DatePickerState> endDateKey = GlobalKey<DatePickerState>();
  late String use = "broker";
  late String token = BlocProvider.of<AuthBloc>(context).state.token;
  late String startDate = '';
  late String endDate = '';
  late DateTime startDateTime = DateTime.now().add(const Duration(days: -14));
  late DateTime endDateTime = DateTime.now();
  late String detailsDate = '';
  late num detailsPrice = 0;
  late List<BrokerData> brokers = [];
  late Map<String, BrokerInOut> brokerData = {};
  late List<StockTrade> timeData = [];
  late List<BrokerInOutDetails> brokerDetailsData = [];

  return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 400
      ),
      child: IntrinsicHeight(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Collapse(
                key: collapseDateKey,
                header: const SettingTitle(title: "日期篩選"),
                content: Column(
                  children: [
                    Row(
                      children: [
                        const Text("開始", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        WDatePicker(
                          key: startDateKey,
                          currentTime: startDateTime,
                          callBack: (date) async {
                            startDateTime = date;
                            var difference = startDateTime.difference(endDateTime).inDays;
                            if (difference > 0) {
                              endDateTime = startDateTime;
                              endDate = DateFormat('yyyy-MM-dd').format(endDateTime);
                              endDateKey.currentState!.updateDate(endDateTime);
                            } else if (difference < -14) {
                              endDateTime = startDateTime.add(const Duration(days: 14));
                              endDate = DateFormat('yyyy-MM-dd').format(endDateTime);
                              endDateKey.currentState!.updateDate(endDateTime);
                            }
                            if (startDate != '') {
                              startDate = DateFormat('yyyy-MM-dd').format(date);
                              if (use == 'broker') {
                                brokerData = await getBrokerInOutData(token, code, startDate, endDate, brokers, context);
                                print(brokerData);
                                contentKey.currentState!.updateBrokerData(brokerData);
                              } else if (use == 'time') {
                                timeData = await getTimeInOutData(token, code, startDate, endDate, brokers, context);
                                contentKey.currentState!.updateTimeData(timeData);
                              }
                            } else {
                              startDate = DateFormat('yyyy-MM-dd').format(date);
                            }
                          }
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text("結束", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        WDatePicker(
                          key: endDateKey,
                          currentTime: endDateTime,
                          callBack: (date) async {
                            endDateTime = date;
                            var difference = startDateTime.difference(endDateTime).inDays;
                            if (difference > 0) {
                              startDateTime = endDateTime;
                              startDate = DateFormat('yyyy-MM-dd').format(startDateTime);
                              startDateKey.currentState!.updateDate(startDateTime);
                            } else if (difference < -14) {
                              startDateTime = endDateTime.add(const Duration(days: -14));
                              startDate = DateFormat('yyyy-MM-dd').format(startDateTime);
                              startDateKey.currentState!.updateDate(startDateTime);
                            }
                            if (endDate != '') {
                              endDate = DateFormat('yyyy-MM-dd').format(date);
                              if (use == 'broker') {
                                brokerData = await getBrokerInOutData(token, code, startDate, endDate, brokers, context);
                                print(brokerData);
                                contentKey.currentState!.updateBrokerData(brokerData);
                              } else if (use == 'time') {
                                timeData = await getTimeInOutData(token, code, startDate, endDate, brokers, context);
                                contentKey.currentState!.updateTimeData(timeData);
                              }
                            } else {
                              endDate = DateFormat('yyyy-MM-dd').format(date);
                            }
                          }
                        )
                      ],
                    ),
                  ]
                )
              ),
              const Hr(),
              Collapse(
                key: collapseBrokerKey,
                header: const SettingTitle(title: "我的券商"),
                content: Column(
                  children: [
                    ChooseBroker(
                      callBack: (brokerList) async { 
                        brokers = brokerList;
                        collapseBrokerKey.currentState!.closeCollapse();
                        if (use == 'broker') {
                          brokerData = await getBrokerInOutData(token, code, startDate, endDate, brokers, context);
                          contentKey.currentState!.updateBrokerData(brokerData);
                        } else if (use == 'time') {
                          timeData = await getTimeInOutData(token, code, startDate, endDate, brokers, context);
                          contentKey.currentState!.updateTimeData(timeData);
                        }
                      }
                    ),
                  ]
                )
              ),
              const Hr(),
              ChangeButton(
                key: changeButtonKey,
                callBack: (useWidget) async {
                  use = useWidget;
                  contentKey.currentState!.updateIsBroker(use);
                  if (brokers.isNotEmpty) {
                    if (use == 'broker') {
                      brokerData = await getBrokerInOutData(token, code, startDate, endDate, brokers, context);
                      contentKey.currentState!.updateBrokerData(brokerData);
                    } else if (use == 'time') {
                      timeData = await getTimeInOutData(token, code, startDate, endDate, brokers, context);
                      contentKey.currentState!.updateTimeData(timeData);
                    }
                  }
                }
              ),
              InOutContent(
                key: contentKey,
                use: use,
                brokerData: brokerData,
                timeData: timeData,
                brokerDetails: brokerDetailsData,
                date: detailsDate,
                price: detailsPrice,
                toDetails: (price, date) async {
                  use = 'details';
                  detailsDate = date;
                  detailsPrice = price;
                  changeButtonKey.currentState!.updateUse(use);
                  contentKey.currentState!.updateIsBroker(use);
                  contentKey.currentState!.updateDate(detailsDate);
                  contentKey.currentState!.updatePrice(detailsPrice);
                  brokerDetailsData = await getBrokerDetails(token, code, date, date, price, brokers, context);
                  contentKey.currentState!.updateBrokerDetailsData(brokerDetailsData);
                }
              )
            ],
          ),
        )
      )
    );
}

Future<Map<String, BrokerInOut>> getBrokerInOutData(String token, String code, String startDate, String endDate, List<BrokerData> brokerDataList, BuildContext context) async {
  EasyLoading.show(status: 'loading...');
  List<String> brokerList = [];
  for (var item in brokerDataList) {
    brokerList.add("${item.first}-${item.second}");
  }
  BrokerInOutReq body = BrokerInOutReq(
    token: token,
    code: code,
    startDate: startDate,
    endDate: endDate,
    broker: brokerList
  );
  var res = await getBrokerInOut(code, body);

  if (res.code != 10000) {
    apiErrorAction(res.code, '取得券商進出失敗', context);
  }
  EasyLoading.dismiss();

  return res.body!;
}

Future<List<StockTrade>> getTimeInOutData(String token, String code, String startDate, String endDate, List<BrokerData> brokerDataList, BuildContext context) async {
  EasyLoading.show(status: 'loading...');
  List<String> brokerList = [];
  for (var item in brokerDataList) {
    brokerList.add("${item.first}-${item.second}");
  }
  BrokerInOutReq body = BrokerInOutReq(
    token: token,
    code: code,
    startDate: startDate,
    endDate: endDate,
    broker: brokerList
  );
  var res = await getTimeInOut(code, body);

  if (res.code != 10000) {
    apiErrorAction(res.code, '取得分點進出失敗', context);
  }
  EasyLoading.dismiss();

  return res.body!;
}

Future<List<BrokerInOutDetails>> getBrokerDetails(String token, String code, String startDate, String endDate, num price, List<BrokerData> brokerDataList, BuildContext context) async {
  EasyLoading.show(status: 'loading...');
  List<String> brokerList = [];
  for (var item in brokerDataList) {
    brokerList.add("${item.first}-${item.second}");
  }
  BrokerInOutDetailsReq body = BrokerInOutDetailsReq(
    token: token,
    code: code,
    startDate: startDate,
    endDate: endDate,
    broker: brokerList,
    price: price
  );
  var res = await getBrokerInOutDetails(code, body);

  if (res.code != 10000) {
    apiErrorAction(res.code, '取得券商詳細資料失敗', context);
  }
  EasyLoading.dismiss();

  return res.body!;
}

Future<ApiRes> addMyBroker(String token, String myBrokerName, Map<String, List<String>> data) async {
  List<BrokerData> body = [];

  data.keys.toList().forEach((key) {
    for (var item in data[key]!) {
      BrokerData subBody = BrokerData(first: key, second: item);
      body.add(subBody);
    }
  });

  var res = createMyBroker(token, myBrokerName, body);

  return res;
}
