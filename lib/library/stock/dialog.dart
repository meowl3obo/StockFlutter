import 'package:flutter/material.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/config/stock.dart';
import 'package:flutter_application/infrastructure/stock.dart';
import 'package:flutter_application/library/broker/dialog.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/library/global/url_launcher.dart';
import 'package:flutter_application/library/group/dialog.dart';
import 'package:flutter_application/library/stock/style.dart';
import 'package:flutter_application/model/stock.dart';
import 'package:flutter_application/widget/stock/kStick.dart';
import 'package:flutter_application/widget/stock/lineChart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future showStockDialog(String code, BuildContext mainContext) async {
  var res = await getStockInfo(code);
  if (res.code != 10000) {
    apiErrorAction(res.code, '取得股票資訊失敗', mainContext);
  }
  var data = res.body!;
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
      title: titleBar(data, context, mainContext),
      content: SingleChildScrollView(
        child: content(data, context),
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

Future showWarningDialog(String code, BuildContext mainContext) async {
  var res = await getWarningStockInfo(code);
  if (res.code != 10000) {
    apiErrorAction(res.code, '取得股票資訊失敗', mainContext);
  }
  var data = res.body!;
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
      title: titleBar(data, context, mainContext),
      content: SingleChildScrollView(
        child: content(data, context),
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

Widget titleBar(StockInfoDetails data, BuildContext context, BuildContext mainContext) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text("${data.name}-${data.code}"),
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
                  showAddStockDialog(data.code, data.name, context, state.group)
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
          Navigator.pop(context, 'Cancel');
          showBrokerDialog(data.code, data.name, mainContext);
        },
        child: Row(
          children: [
            Text(
              "券商進出",
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

Widget content(StockInfoDetails data, BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      title("交易資訊", context),
      rowTwoData("收盤價", "成交量(張)", 
        Text(
          data.closePrice.toString(), 
          style: TextStyle(color: checkUpDown(data.change), fontSize: 16)), 
        Text(((data.volume / 100).round()/10).toString(), style: const TextStyle(fontSize: 16))),
      rowTwoData("漲跌", "本益比", 
        Text(
          data.change.toString(), 
          style: TextStyle(color: checkUpDown(data.change), fontSize: 16)), 
        Text(((data.per * 100).round()/100).toString(), style: const TextStyle(fontSize: 16))),
      rowTwoData("漲跌幅", "股價淨值比", 
        Text(
          "${((data.priceDiff*100).round() / 100).toString()}%", 
          style: TextStyle(color: checkUpDown(data.change), fontSize: 16)), 
        Text(((data.pbr * 100).round()/100).toString(), style: const TextStyle(fontSize: 16))),
      rowSingleDataWidthMax("今日K棒", KStick(closePrice: data.closePrice, openPrice: data.openPrice, high: data.highestPrice, low: data.lowestPrice), context),
      rowSingleDataWidthMax("30日趨勢", LineChartListener(yPoint: data.closePriceTrend), context),
      title("基本資料", context),
      rowTwoData("上市櫃", "產業", Text(stockClass[data.stockClass]!, style: const TextStyle(fontSize: 16)), Text(data.industry, style: const TextStyle(fontSize: 16))),
      rowSingleDataWidthMax("股本(億)",
        Text(((data.paidInCapital/1000000).round()/100).toString(), style: const TextStyle(fontSize: 16)),
        context
      ),
      if (data.reason != null) title("注意 / 處置資訊", context),
      if (data.reason != null) rowSingleDataWidthMax("分類",
        Text(warningStockMapping[data.status]!, style: const TextStyle(fontSize: 16)),
        context
      ),
      if (data.reason != null) Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Column(
          children: [
            Row(
              children: [
                Text("處置內容", style: subTitleStyle()),
              ],
            ),
            Text(data.reason.replaceAll("<br>", "\n"), style: const TextStyle(fontSize: 16)),
          ],
        )
      ),
      title("外部連結", context),
      rowTwoLink("Yahoo", "HiStock", "https://tw.stock.yahoo.com/quote/${data.code}", "https://histock.tw/stock/${data.code}#price"),
      rowTwoLink("玩股網", "PChome", "https://www.wantgoo.com/stock/${data.code}?price", "https://pchome.megatime.com.tw/stock/sid${data.code}.html?price"),
      rowTwoLink("股市同學會", "TradingView", "https://www.cmoney.tw/forum/stock/${data.code}#price", "https://tw.tradingview.com/symbols/${data.stockClass == 'TSE' ? 'TWSE'  : 'TPEX'}-${data.code}/"),
    ],
  );
}

Widget title(String text, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: rootColor['hr']!
        )
      )
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold
        )
      ),
    ),
  );
}

TextStyle subTitleStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16
  );
}

Widget rowSingleDataWidthMax(String title, Widget value, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: subTitleStyle()),
            value
          ],
        ),
      ),
      const SizedBox(width: 5),
      SizedBox(width: MediaQuery.of(context).size.width*0.45)
    ],
  );
}

Widget rowSingleData(String title, Widget value) {
  return Row(
    children: [
      Text(title, style: subTitleStyle()),
      const SizedBox(width: 20),
      value
    ],
  );
}

Widget rowTwoData(String title1, String title2, Widget value1, Widget value2) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title1, style: subTitleStyle()),
              value1
            ]
          )
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title2, style: subTitleStyle()),
              value2
            ]
          )
        )
      ]
    ),
  );
}

Widget rowTwoLink(String title1, String title2, String path1, String path2) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
              onPressed: () => { openPage(path1) },
              child: Row(
                children: [
                  Text(
                    title1,
                    style: TextStyle(
                      color: rootColor['mainFont'],
                      fontSize: 18,)
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    color: rootColor['mainFont'],
                    size: 16.0,
                  ),
                ],
              )
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
              onPressed: () => { openPage(path2) },
              child: Row(
                children: [
                  Text(
                    title2,
                    style: TextStyle(
                      color: rootColor['mainFont'],
                      fontSize: 18,)
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    color: rootColor['mainFont'],
                    size: 16.0,
                  ),
                ],
              )
            ),
          ),
        ),
      ],
    ),
  );
}