import 'package:flutter/material.dart';
import 'package:flutter_application/application/broker/bloc.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/library/broker/dialog.dart';
import 'package:flutter_application/model/broker.dart';
import 'package:flutter_application/widget/global/checkbox.dart';
import 'package:flutter_application/widget/home/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrokerSelect extends StatefulWidget {
  final Function(Map<String, List<String>> resultBroker) onChange;
  const BrokerSelect({Key? key, required this.onChange}) : super(key: key);

  @override
  BrokerSelectState createState() => BrokerSelectState();
}

class BrokerSelectState extends State<BrokerSelect> {
  late bool firstBuild = true;
  late String nowFirstChoose = '我的篩選紀錄';
  late List<BrokerData> chooseBroker = [];
  late String myBrokerChoose = '';
  late Map<String, bool> allUsed = {};
  late Map<String, List<String>> secondUsed = {};
  late Map<String, List<String>> brokerList = {};
  
  void updateUsed(Map<String, List<String>> usedBroker) {
    setState(() {
      for (var item in List<BrokerData>.from(chooseBroker)) {
        if (!usedBroker.keys.toList().contains(item.first) || !usedBroker[item.first]!.contains(item.second)) {
          chooseBroker.removeWhere((x) => x.first == item.first && x.second == item.second);
        }
      }
    });
    setAllUsed();
  }

  void setAllUsed() {
    setState(() {
      brokerList.keys.toList().forEach((key) {
        var thisKeyUsedChild = chooseBroker.where((x) => x.first == key).toList();
        if (thisKeyUsedChild.length >= brokerList[key]!.length) {
          allUsed[key] = true;
        } else {
          allUsed[key] = false;
        }
        secondUsed[key] = thisKeyUsedChild.map<String>((x) => x.second).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    brokerList = BlocProvider.of<BrokerBloc>(context).state.brokers;
    if (firstBuild) {
      setAllUsed();
      firstBuild = false;
    }
    return Column(
      children: [
        const SettingTitle(title: "券商篩選器"),
        SizedBox(
          height: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: rootColor['border']!)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: rootColor['border']!)
                          ),
                          color: nowFirstChoose == "我的篩選紀錄" ? rootColor['focusButton'] : rootColor['transparent'],
                        ),
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        width: (MediaQuery.of(context).size.width - 38) / 2,
                        child: ChooseButton(
                          text: "我的篩選紀錄",
                          callback: () => {
                            if (nowFirstChoose != "我的篩選紀錄") {
                              setState(() { nowFirstChoose = "我的篩選紀錄"; })
                            }
                          },
                        )
                      ),
                      for (var key in brokerList.keys.toList()) Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: rootColor['border']!)
                          ),
                          color: nowFirstChoose == key ? rootColor['focusButton'] : rootColor['transparent'],
                        ),
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        width: (MediaQuery.of(context).size.width - 38) / 2,
                        child: ChooseButton(
                          text: key,
                          callback: () => { 
                            if (nowFirstChoose != key) {
                              setState(() { nowFirstChoose = key; })
                            }
                          },
                        )
                      )
                    ],
                  )
                ),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: rootColor['border']!)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (nowFirstChoose == '我的篩選紀錄') BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                        return Row(
                          children: [
                            for (var key in state.myBrokers.keys.toList()) Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: rootColor['border']!)
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              width: (MediaQuery.of(context).size.width - 38) / 2,
                              child: CheckboxItemNotBoldAndLeft(
                                title: key,
                                value: myBrokerChoose == key,
                                onChange: (bool val) {
                                  if (myBrokerChoose != key) {
                                    setState(() { 
                                      myBrokerChoose = key;
                                    });
                                    chooseBroker = List<BrokerData>.from(state.myBrokers[key]!);
                                    setAllUsed();
                                    widget.onChange(secondUsed);
                                  } else {
                                    setState(() { 
                                      myBrokerChoose = '';
                                    });
                                    chooseBroker = [];
                                    setAllUsed();
                                    widget.onChange(secondUsed);
                                  }
                                }
                              ),
                            )
                          ],
                        );
                      })
                      else ...[
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: rootColor['border']!)
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          width: (MediaQuery.of(context).size.width - 38) / 2,
                          child: CheckboxItemNotBoldAndLeft(
                            title: '全選',
                            value: allUsed[nowFirstChoose]!,
                            onChange: (bool val) {
                              if (val) {
                                brokerList[nowFirstChoose]!.forEach((item) {
                                  BrokerData checkItem = BrokerData(first: nowFirstChoose, second: item);
                                  if (!chooseBroker.contains(checkItem)) {
                                    chooseBroker.add(checkItem);
                                  }
                                });
                              } else {
                                chooseBroker.where((x) => x.first == nowFirstChoose).toList().forEach((item) => {
                                  chooseBroker.removeWhere((x) => x.first == item.first && x.second == item.second)
                                });
                              }
                              setState(() { 
                                setAllUsed();
                              });
                              widget.onChange(secondUsed);
                            }
                          )
                        ),
                        for (var item in brokerList[nowFirstChoose]!) Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: rootColor['border']!)
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          width: (MediaQuery.of(context).size.width - 38) / 2,
                          child: CheckboxItemNotBoldAndLeft(
                            title: item == '總行' ? item : '$item分行',
                            value: secondUsed[nowFirstChoose]!.contains(item),
                            onChange: (bool val) {
                              if (val) {
                                BrokerData checkItem = BrokerData(first: nowFirstChoose, second: item);
                                chooseBroker.add(checkItem);
                              } else {
                                chooseBroker.removeWhere((x) => x.first == nowFirstChoose && x.second == item);
                              }
                              setState(() { 
                                setAllUsed();
                              });
                              widget.onChange(secondUsed);
                            }
                          )
                        )
                      ],
                    ],
                  )
                )
              )
            ],
          )
        )
      ],
    );
  }
}

class BrokerResult extends StatefulWidget {
  final Function(Map<String, List<String>> resultBroker) onChange;
  const BrokerResult({Key? key, required this.onChange}) : super(key: key);

  @override
  BrokerResultState createState() => BrokerResultState();
}

class BrokerResultState extends State<BrokerResult> {
  late Map<String, List<String>> resultBroker = {};
  late String nowFirstChoose = '';
  
  void updateResult(Map<String, List<String>> usedBroker) {
    setState(() {
      usedBroker.keys.toList().forEach((key) {
        if (usedBroker[key]!.isNotEmpty) {
          resultBroker[key] = usedBroker[key]!;
        } else {
          resultBroker.remove(key);
        }
      });
    });
  }

  void removeItem(String second) {
    setState(() {
      resultBroker[nowFirstChoose]!.removeWhere((x) => x == second);
      if (resultBroker[nowFirstChoose]!.isEmpty) {
        resultBroker.remove(nowFirstChoose);
      }
    });
    widget.onChange(resultBroker);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SettingTitle(title: "篩選結果"),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    resultBroker = {};
                    widget.onChange(resultBroker);
                  },
                  child: Text(
                    "清除",
                    style: TextStyle(
                      color: rootColor['danger']
                    ),
                  )
                ),
                TextButton(
                  onPressed: () {
                    showStoreBrokerDialog(resultBroker, context);
                  },
                  child: Text(
                    "儲存",
                    style: TextStyle(
                      color: rootColor['success']
                    ),
                  )
                )
              ],
            ),
          ],
        ),

        SizedBox(
          height: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: (MediaQuery.of(context).size.width - 34) / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: rootColor['border']!)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var key in resultBroker.keys.toList()) Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: rootColor['border']!)
                          ),
                          color: nowFirstChoose == key ? rootColor['focusButton'] : rootColor['transparent'],
                        ),
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        width: (MediaQuery.of(context).size.width - 38) / 2,
                        child: ChooseButton(
                          text: key,
                          callback: () => { 
                            if (nowFirstChoose != key) {
                              setState(() { nowFirstChoose = key; })
                            }
                          },
                        )
                      )
                    ],
                  )
                ),
              ),
              Container(
                height: 250,
                width: (MediaQuery.of(context).size.width - 34) / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: rootColor['border']!)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (resultBroker.keys.toList().contains(nowFirstChoose)) ...[
                        for (var item in resultBroker[nowFirstChoose]!) Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: rootColor['border']!)
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          width: (MediaQuery.of(context).size.width - 38) / 2,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                child: IconButton(
                                  iconSize: 16,
                                  padding: const EdgeInsets.all(0.0),
                                  onPressed: () { removeItem(item); },
                                  icon: Icon(
                                    Icons.delete,
                                    color: rootColor['danger'],
                                  )
                                ),
                              ),
                              Expanded(
                                child: ChooseButton(
                                  text: item == '總行' ? item : '$item分行',
                                  callback: () => { removeItem(item) }
                                ),
                              )
                            ],
                          )
                        )
                      ]
                    ],
                  )
                )
              )
            ],
          )
        )
      ],
    );
  }
}

class ChooseButton extends StatelessWidget {
  final String text;
  final Function() callback;
  const ChooseButton({Key? key, required this.text, required this.callback}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft),
      child: Text(
        text,
        style: TextStyle(
          color: rootColor['mainFont'],
          fontSize: 16,
        )
      ),
    );
  }
}