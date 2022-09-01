import 'package:flutter/material.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/model/broker.dart';
import 'package:flutter_application/widget/home/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class WDatePicker extends StatefulWidget {
  late DateTime currentTime;
  final Function(DateTime) callBack;
  WDatePicker({Key? key, required this.currentTime, required this.callBack}): super(key: key);

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<WDatePicker> {
  late String chooseDate = DateFormat('yyyy-MM-dd').format(widget.currentTime);

  void updateDate(DateTime date) {
    setState(() {
      widget.currentTime = date;
      chooseDate = DateFormat('yyyy-MM-dd').format(widget.currentTime);
    });
  }

  @override
  void initState() {
    widget.callBack(widget.currentTime);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1.0, color: rootColor['border']!),
          ),
          onPressed: () {
            DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              onConfirm: (date) {
                setState(() {
                  widget.currentTime = date;
                  chooseDate = DateFormat('yyyy-MM-dd').format(widget.currentTime);
                  widget.callBack(date);
                });
              },
              currentTime: widget.currentTime, 
              locale: LocaleType.zh
            );
          },
          child: Text(
            chooseDate,
            style: TextStyle(color: rootColor['mainFont']),
          ),
        )
      ),
    );
  }
}

class ChangeButton extends StatefulWidget {
  final Function(String) callBack;
  const ChangeButton({Key? key, required this.callBack}) : super(key: key);

  @override
  ChangeButtonState createState() => ChangeButtonState();
}

class ChangeButtonState extends State<ChangeButton> {
  String use = 'broker';

  void updateUse(String useWidget){
    setState(() { use = useWidget; });
  }

  @override
  Widget build(BuildContext context) {
    if (use != 'details') {
      return Container(
        alignment: Alignment.centerRight,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1.0, color: rootColor['hr']!),
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0)
          ),
          onPressed: () { setState(() {
            use = use == 'broker' ? 'time' : 'broker';
            widget.callBack(use);
          });},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.swap_horiz,
                color: rootColor['mainFont'],
                size: 24.0,
              ),
              Text(
                use == 'broker' ? '分點進出' : '券商進出',
                style: TextStyle(color: rootColor['mainFont'])
              )
            ],
          ),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.centerLeft,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1.0, color: rootColor['hr']!),
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0)
          ),
          onPressed: () { setState(() {
            use = 'broker';
            widget.callBack(use);
          });},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios_rounded,
                color: rootColor['mainFont'],
                size: 24.0,
              ),
              Text(
                '券商進出',
                style: TextStyle(color: rootColor['mainFont'])
              )
            ],
          ),
        ),
      );
    }
  }
}

class ChooseBroker extends StatefulWidget {
  final Function(List<BrokerData>) callBack;

  const ChooseBroker({Key? key, required this.callBack}) : super(key: key);

  @override
  ChooseBrokerState createState() => ChooseBrokerState();
}

class ChooseBrokerState extends State<ChooseBroker> {
  late String chooseBroker = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      return Theme(
        data: ThemeData(
          unselectedWidgetColor: rootColor['lightBorder'],
        ),
        child: Column(
          children: [
            for (var item in state.myBrokers.keys.toList()) SizedBox(
              height: 36,
              child: Row(
                children: [
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: item,
                    groupValue: chooseBroker,
                    onChanged: (String? value) {
                      setState(() {
                        chooseBroker = value!;
                        widget.callBack(state.myBrokers[item]!);
                      });
                    },
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          chooseBroker = item;
                          widget.callBack(state.myBrokers[item]!);
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 16,
                            color: rootColor['mainFont']
                          )
                        ),
                      )
                    )
                  )
                ],
              ),
            )
          ],
        )
      );
    });
  }
}

class BrokerInOutTable extends StatefulWidget {
  late Map<String, BrokerInOut> data;
  late Function(num, String) toDetails;

  BrokerInOutTable({Key? key, required this.data, required this.toDetails}): super(key: key);

  @override
  BrokerInOutTableState createState() => BrokerInOutTableState();
}

class BrokerInOutTableState extends State<BrokerInOutTable> {
  String nowSort = '';

  void updateData(Map<String, BrokerInOut> data) {
    setState(() {
      widget.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var key in widget.data.keys.toList()) Column(
          children: [
            Container(
              color: rootColor['tableThead'],
              child: Center(
                child: Text(
                  key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1.1),
                2: FlexColumnWidth(1.1),
                3: IntrinsicColumnWidth(flex: 1.3),
              },
              border: TableBorder.all(),
              children: <TableRow>[
                TableRow(
                  children: [
                    WSubTh(
                      title: "成交價",
                      useSort: true,
                      onTap: () {
                        nowSort = nowSort == 'price' ? '!price' : 'price';
                        setState(() {
                          widget.data = sortBrokerData(widget.data, nowSort.contains('!'), 'price', key);
                        });
                      }
                    ),
                    WSubTh(
                      title: "買進(張)",
                      useSort: true,
                      onTap: () {
                        nowSort = nowSort == 'buy' ? '!buy' : 'buy';
                        setState(() {
                          widget.data = sortBrokerData(widget.data, nowSort.contains('!'), 'buy', key);
                        });
                      }
                    ),
                    WSubTh(
                      title: "賣出(張)",
                      useSort: true,
                      onTap: () {
                        nowSort = nowSort == 'sell' ? '!sell' : 'sell';
                        setState(() {
                          widget.data = sortBrokerData(widget.data, nowSort.contains('!'), 'sell', key);
                        });
                      }
                    ),
                    WSubTh(
                      title: "買賣超(張)",
                      useSort: true,
                      onTap: () {
                        nowSort = nowSort == 'buySell' ? '!buySell' : 'buySell';
                        setState(() {
                          widget.data = sortBrokerData(widget.data, nowSort.contains('!'), 'buySell', key);
                        });
                      }
                    ),
                  ]
                ),
                for (var item in widget.data[key]!.stockTrades) TableRow(children: [
                  TableCell(
                    child: GestureDetector(
                      onTap: () {
                        widget.toDetails(item.price, key);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                        child: Center(
                          child: Text(
                            ((item.price * 100).round()/100).toString(),
                            style: TextStyle(
                              color: item.price > widget.data[key]!.yesterdayClosePrice ? rootColor['danger'] : item.price < widget.data[key]!.yesterdayClosePrice ? rootColor['success'] : rootColor['mainFont']
                            ),
                          )
                        )
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(((item.buy / 10).round()/100).toString())
                      )
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(((item.sell / 10).round()/100).toString())
                      )
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          (((item.buy - item.sell) / 10).round() / 100).toString(),
                          style: TextStyle(
                            color: (item.buy - item.sell) > 0 ? rootColor['danger'] : item.buy - item.sell < 0 ? rootColor['success'] : rootColor['mainFont']
                          ),
                        )
                      )
                    ),
                  ),
                ])
              ]
            ),
            const SizedBox(height: 10)
          ],
        ),
      ],
    );
  }
}

class TimeInOutTable extends StatefulWidget {
  late List<StockTrade> data;

  TimeInOutTable({Key? key, required this.data}): super(key: key);

  @override
  TimeInOutTableState createState() => TimeInOutTableState();
}

class TimeInOutTableState extends State<TimeInOutTable> {
  String nowSort = '';

  void updateData(List<StockTrade> data) {
    setState(() {
      widget.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.1),
        2: FlexColumnWidth(1.1),
        3: IntrinsicColumnWidth(flex: 1.3),
      },
      border: TableBorder.all(),
      children: <TableRow>[
        TableRow(
          children: [
            WSubTh(
              title: "成交價",
              useSort: true,
              onTap: () {
                nowSort = nowSort == 'price' ? '!price' : 'price';
                setState(() {
                  widget.data = sortTimeData(widget.data, nowSort.contains('!'), 'price');
                });
              }
            ),
            WSubTh(
              title: "買進(張)",
              useSort: true,
              onTap: () {
                nowSort = nowSort == 'buy' ? '!buy' : 'buy';
                setState(() {
                  widget.data = sortTimeData(widget.data, nowSort.contains('!'), 'buy');
                });
              }
            ),
            WSubTh(
              title: "賣出(張)",
              useSort: true,
              onTap: () {
                nowSort = nowSort == 'sell' ? '!sell' : 'sell';
                setState(() {
                  widget.data = sortTimeData(widget.data, nowSort.contains('!'), 'sell');
                });
              }
            ),
            WSubTh(
              title: "買賣超(張)",
              useSort: true,
              onTap: () {
                nowSort = nowSort == 'buySell' ? '!buySell' : 'buySell';
                setState(() {
                  widget.data = sortTimeData(widget.data, nowSort.contains('!'), 'buySell');
                });
              }
            ),
          ]
        ),
        for (var item in widget.data) TableRow(children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              child: Center(
                child: Text(
                  ((item.price * 100).round()/100).toString(),
                )
              )
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(((item.buy / 10).round()/100).toString())
              )
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(((item.sell / 10).round()/100).toString())
              )
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  (((item.buy - item.sell) / 10).round() / 100).toString(),
                  style: TextStyle(
                    color: (item.buy - item.sell) > 0 ? rootColor['danger'] : item.buy - item.sell < 0 ? rootColor['success'] : rootColor['mainFont']
                  ),
                )
              )
            ),
          ),
        ])
      ]
    );
  }
}

class BrokerInOutDetailsTable extends StatefulWidget {
  late String date;
  late num price;
  late List<BrokerInOutDetails> data;

  BrokerInOutDetailsTable({Key? key, required this.data, required this.date, required this.price}): super(key: key);

  @override
  BrokerInOutDetailsTableState createState() => BrokerInOutDetailsTableState();
}

class BrokerInOutDetailsTableState extends State<BrokerInOutDetailsTable> {
  String nowSort = '';

  void updateData(List<BrokerInOutDetails> data) {
    setState(() {
      widget.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: rootColor['tableThead'],
          child: Center(
            child: Text(
              "${widget.date}-\$ ${widget.price}",
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            )
          ),
        ),
        Table(
              columnWidths: const {
                0: FlexColumnWidth(2.0),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1.2),
              },
              border: TableBorder.all(),
              children: <TableRow>[
                TableRow(
                  children: [
                    WSubTh(
                      title: "分行",
                      useSort: false,
                      onTap: () {}
                    ),
                    WSubTh(
                      title: "買進(張)",
                      useSort: false,
                      onTap: () {}
                    ),
                    WSubTh(
                      title: "賣出(張)",
                      useSort: false,
                      onTap: () {}
                    ),
                    WSubTh(
                      title: "買賣超(張)",
                      useSort: false,
                      onTap: () {}
                    ),
                  ]
                ),
                for (var item in widget.data) TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Center(
                        child: Text(
                          item.branch,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        )
                      )
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(((item.buy / 10).round()/100).toString())
                      )
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(((item.sell / 10).round()/100).toString())
                      )
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          (((item.buy - item.sell) / 10).round() / 100).toString(),
                          style: TextStyle(
                            color: (item.buy - item.sell) > 0 ? rootColor['danger'] : item.buy - item.sell < 0 ? rootColor['success'] : rootColor['mainFont']
                          ),
                        )
                      )
                    ),
                  ),
                ])
              ]
            ),
            const SizedBox(height: 10)
          ],
    );
  }
}

class InOutContent extends StatefulWidget {
  late String use;
  late Map<String, BrokerInOut> brokerData = {};
  late List<StockTrade> timeData = [];
  late List<BrokerInOutDetails> brokerDetails = [];
  late Function(num, String) toDetails;
  late String date;
  late num price;
  InOutContent({Key? key, required this.use, required this.brokerData, required this.timeData, required this.toDetails, required this.brokerDetails, required this.date, required this.price}): super(key: key);

  @override
  InOutContentState createState() => InOutContentState();
}

class InOutContentState extends State<InOutContent> {
  final GlobalKey<BrokerInOutTableState> brokerTableKey = GlobalKey<BrokerInOutTableState>();
  final GlobalKey<TimeInOutTableState> timeTableKey = GlobalKey<TimeInOutTableState>();

  void updateBrokerData(Map<String, BrokerInOut> brokerData) {
    setState(() {
      widget.brokerData = brokerData;
    });
  }
  void updateTimeData(List<StockTrade> timeData) {
    setState(() {
      widget.timeData = timeData;
    });
  }
  void updateBrokerDetailsData(List<BrokerInOutDetails> brokerDetails) {
    setState(() {
      widget.brokerDetails = brokerDetails;
    });
  }
  void updateIsBroker(String use) {
    setState(() {
      widget.use = use;
    });
  }
  void updateDate(String date) {
    setState(() {
      widget.date = date;
    });
  }
  void updatePrice(num price) {
    setState(() {
      widget.price = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.use == 'broker') {
      return  BrokerInOutTable(
        key: brokerTableKey,
        data: widget.brokerData,
        toDetails: widget.toDetails
      );
    } else if (widget.use == 'time') {
      return TimeInOutTable(
        key: timeTableKey,
        data: widget.timeData,
      );
    } else {
      return BrokerInOutDetailsTable(
        key: timeTableKey,
        data: widget.brokerDetails,
        date: widget.date,
        price: widget.price
      );
    }
  }
}

Map<String, BrokerInOut> sortBrokerData(Map<String, BrokerInOut> socure, bool isReverse, String key, String date) {
  if (isReverse) {
    if (key == 'buySell') {
      socure[date]!.stockTrades.sort((a, b) => (a.buy-a.sell).compareTo((b.buy-b.sell)));
    } else {
      socure[date]!.stockTrades.sort((a, b) => a.toMap()[key].compareTo(b.toMap()[key]));
    }
  } else {
    if (key == 'buySell') {
      socure[date]!.stockTrades.sort((a, b) => (b.buy-b.sell).compareTo((a.buy-a.sell)));
    } else {
      socure[date]!.stockTrades.sort((a, b) => b.toMap()[key].compareTo(a.toMap()[key]));
    }
  }
  Map<String, BrokerInOut> data = socure;

  return data;
}

List<StockTrade> sortTimeData(List<StockTrade> socure, bool isReverse, String key) {
  if (isReverse) {
    if (key == 'buySell') {
      socure.sort((a, b) => (a.buy-a.sell).compareTo((b.buy-b.sell)));
    } else {
      socure.sort((a, b) => a.toMap()[key].compareTo(b.toMap()[key]));
    }
  } else {
    if (key == 'buySell') {
      socure.sort((a, b) => (b.buy-b.sell).compareTo((a.buy-a.sell)));
    } else {
      socure.sort((a, b) => b.toMap()[key].compareTo(a.toMap()[key]));
    }
  }
  List<StockTrade> data = socure;

  return data;
}