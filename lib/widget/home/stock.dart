import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/library/stock/dialog.dart';
import 'package:flutter_application/library/stock/style.dart';
import 'package:flutter_application/model/stock.dart';
import 'package:flutter_application/widget/home/global.dart';
import 'package:flutter_application/widget/stock/lineChart.dart';

class StockTable extends StatefulWidget {
  late StockData data = StockData(date: "", stockInfo: []);
  final bool isWarning;
  StockTable({Key? key, required this.data, required this.isWarning}) : super(key: key);

  @override
  StockTableState createState() => StockTableState();
}

class StockTableState extends State<StockTable> {
  String nowSort = '';

  void updateStockData(StockData data) {
    setState(() {
      widget.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: IntrinsicColumnWidth(flex: 1.3),
        },
        border: TableBorder.all(),
        children: <TableRow>[
          TableRow(children: [
            WMainTh(
              title: "股票",
              useSort: true,
              onTap: () {
                nowSort = nowSort == 'code' ? '!code' : 'code';
                setState(() {
                  widget.data = sortData(widget.data, nowSort.contains('!'), 'code');
                });
              }),
            WSubTh(
              title: "收盤",
              useSort: true,
              onTap: () {
                nowSort = nowSort == 'closePrice' ? '!closePrice' : 'closePrice';
                setState(() {
                  widget.data = sortData(widget.data, nowSort.contains('!'), 'closePrice');
                });
              }),
            WSubTh(title: "30日趨勢", useSort: false, onTap: () {}),
            ]),
            for (var item in widget.data.stockInfo)
              TableRow(children: [
                TableCell(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.isWarning) {
                        showWarningDialog(item.code, context);
                      } else {
                        showStockDialog(item.code, context);
                      }
                    },
                    child: Container(
                      color: rootColor['tableLeftBody'],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: Center(
                          child: Column(
                            children: [
                              Text(item.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: rootColor['darkFont'])),
                              Text(item.code,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: rootColor['danger']))
                            ],
                          )
                        )
                      )
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Center(
                      child: Column(
                        children: [
                          Text(item.closePrice.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: checkUpDown(item.change))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ((item.change * 100).round() / 100).toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: checkUpDown(item.change))),
                              Text(
                                " (${((item.priceDiff * 100).round() / 100)}%)",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: checkUpDown(item.change)))
                            ],
                          ),
                        ],
                      )
                    )
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child:
                        LineChartListener(yPoint: item.closePriceTrend))),
                ),
              ])
          ]),
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
