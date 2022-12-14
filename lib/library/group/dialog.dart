import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/application/stock/bloc.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/library/global/data.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/library/group/update.dart';
import 'package:flutter_application/model/stock.dart';
import 'package:flutter_application/widget/dialog/group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future showAddStockDialog(String code, String name, BuildContext mainContext, List<MyGroup> group) async {
  int chooseGroup = group[0].id;
  var authBloc = BlocProvider.of<AuthBloc>(mainContext);
  String token = authBloc.state.token;
  int rank = authBloc.state.rank;
  List<MyGroup> groups = BlocProvider.of<UserBloc>(mainContext).state.group;
  return showDialog<String>(
    context: mainContext,
    barrierColor: rootColor['backdrop'],
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: rootColor['cardBg'],
      insetPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      titlePadding: const EdgeInsets.fromLTRB(25, 10, 25, 1),
      contentPadding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      // titlePadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      // contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      actionsPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
      titleTextStyle: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 16,
      ),
      title: Container(
        alignment: Alignment.centerLeft,
        child: Text("$name-$code"),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(150, 0, 150, 0)),
            Center(
              child: Text(
                "??? $name-$code ??????????????????????????????",
              )
            ),
            Center(
              child: GroupSelect(
                chooseGroup: chooseGroup, 
                group: group,
                callBack: (value) { chooseGroup = value; },
                code: code
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            "??????",
            style: TextStyle(
              color: rootColor['danger'],
              fontSize: 16,
            )
          ),
        ),
        TextButton(
            onPressed: () async {
              if (!checkStockInGroup(group, chooseGroup, code)) {
                Navigator.pop(context, 'Cancel');
                showFlushbar('???????????????????????????????????????', mainContext, 'warning', '?????????????????????');
              } else {
                var res = await addStockToGroup(token, filterFroupByCode(group, chooseGroup), code);
                if (res.code == 10000) {
                  getGroup(mainContext, token);
                  Navigator.pop(context, 'Cancel');
                  showFlushbar('????????????????????????????????????', mainContext, 'success', '?????????????????????');
                } else {
                  showFlushbar(res.message, mainContext, 'error', '?????????????????????');
                }
              }
            },
            child: Text(
              "??????",
              style: TextStyle(
                color: rootColor['danger'],
                fontSize: 16,
              )
            ),
          ),
        TextButton(
            onPressed: () async {
              var filterGroup = groups.singleWhere((x) => x.id == chooseGroup);
              if (rank <= 1 && filterGroup.codes.length >= 20) {
                showFlushbar('???????????????????????????20?????????', mainContext, 'error', '?????????????????????');
              } else if (checkStockInGroup(group, chooseGroup, code)) {
                Navigator.pop(context, 'Cancel');
                showFlushbar('??????????????????????????????????????????', mainContext, 'warning', '?????????????????????');
              } else {
                var res = await addStockToGroup(token, filterFroupByCode(group, chooseGroup), code);
                if (res.code == 10000) {
                  getGroup(mainContext, token);
                  Navigator.pop(context, 'Cancel');
                  showFlushbar('???????????????????????????????????????', mainContext, 'success', '?????????????????????');
                } else {
                  showFlushbar(res.message, mainContext, 'error', '?????????????????????');
                }
              }
            },
            child: Text(
              "??????",
              style: TextStyle(
                color: rootColor['success'],
                fontSize: 16,
              )
            ),
          )
      ]
    )
  );
}

Future showCreateGroupDialog(BuildContext mainContext) async {
  final TextEditingController groupNameController = TextEditingController();
  final GlobalKey<StockSelectState> stockSelectKey = GlobalKey<StockSelectState>();
  final GlobalKey<ChoosedStockState> chooseStockKey = GlobalKey<ChoosedStockState>();
  var authBloc = BlocProvider.of<AuthBloc>(mainContext);
  String token = authBloc.state.token;
  int rank = authBloc.state.rank;
  List<MyGroup> groups = BlocProvider.of<UserBloc>(mainContext).state.group;
  Map<String, String> allStocks = {};
  Map<String, String> notChooseStocks = {};
  Map<String, String> chooseStocks = {};
  String groupName = "";
  return showDialog<String>(
    context: mainContext,
    barrierColor: rootColor['backdrop'],
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: rootColor['cardBg'],
      insetPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      titlePadding: const EdgeInsets.fromLTRB(25, 10, 25, 1),
      contentPadding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      // titlePadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      // contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      actionsPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
      titleTextStyle: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 16,
      ),
      title: Container(
        alignment: Alignment.centerLeft,
        child: const Text("?????????????????????"),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            subTitle("????????????", " (???????????????????????????????????????)"),
            TextField(
              style: TextStyle(
                color: rootColor['mainFont'],
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: rootColor['lightBorder']!),
                ),
              ),
              controller: groupNameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              onChanged: (String val) {
                groupName = val;
              },
            ),
            const SizedBox(height: 10),
            subTitle("????????????", " (?????????????????????????????????)"),
            BlocBuilder<StockBloc, StockState>(builder: (context, state) {
              allStocks = state.allStock;
              notChooseStocks = Map<String, String>.from(json.decode(json.encode(state.allStock)));
              return StockSelect(
                key: stockSelectKey,
                allStockMap: state.allStock,
                chooseCallBack: (String val) {
                  chooseStocks[val] = state.allStock[val]!;
                  notChooseStocks.remove(val);
                  chooseStockKey.currentState!.reSetChoosedStockMap(chooseStocks);
                  stockSelectKey.currentState!.reSetAllStockMap(notChooseStocks);
                },
              );
            }),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              child: const Text("????????????"),
            ),
            ChoosedStock(
              key: chooseStockKey,
              choosedStockMap: chooseStocks,
              deleteCallBack: (String val) {
                notChooseStocks[val] = allStocks[val]!;
                chooseStocks.remove(val);
                chooseStockKey.currentState!.reSetChoosedStockMap(chooseStocks);
                stockSelectKey.currentState!.reSetAllStockMap(notChooseStocks);
              }
            ),
          ],
        )
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            "??????",
            style: TextStyle(
              color: rootColor['danger'],
              fontSize: 16,
            )
          ),
        ),
        TextButton(
            onPressed: () async { 
              if (rank <= 1 && groups.length >= 5) {
                showFlushbar('????????????????????????????????????5???', mainContext, 'error', '???????????????????????????');
              } else if (groupName.isEmpty) {
                showFlushbar('???????????????????????????', mainContext, 'error', '???????????????????????????');
              } else {
                var res = await createGroup(token, groupName, chooseStocks);
                if (res.code == 10000) {
                  getGroup(mainContext, token);
                  Navigator.pop(context, 'Cancel');
                  showFlushbar('??????????????????????????????', mainContext, 'success', '?????????????????????');
                } else {
                  showFlushbar(res.message, mainContext, 'error', '?????????????????????');
                }
              }
            },
            child: Text(
              "??????",
              style: TextStyle(
                color: rootColor['success'],
                fontSize: 16,
              )
            ),
          )
      ]
    )
  );
}

Future showUpdateGroupDialog(BuildContext mainContext, int groupId) async {
  final TextEditingController stockController = TextEditingController();
  final GlobalKey<UsedStockState> useStockKey = GlobalKey<UsedStockState>();
  final GlobalKey<UnUsedStockState> unUseStockkKey = GlobalKey<UnUsedStockState>();
  List<String> allGroupStocks = [];
  List<String> allUnUseStocks = [];
  List<String> groupStocks = [];
  List<String> unUseStocks = [];
  late MyGroup useGroup;
  Map<String, String> allStocks = {};
  String stock = "";
  String token = BlocProvider.of<AuthBloc>(mainContext).state.token;

  void setUnUseStocks() {
    allStocks.keys.toList().forEach((item) => {
      if (!allGroupStocks.contains(item)) {
        allUnUseStocks.add(item)
      }
    });
    unUseStocks = allUnUseStocks;
  }

  void filterStock() {
    groupStocks = [];
    unUseStocks = [];
    for (var item in allGroupStocks) {
      if (item.contains(stock)) {
        groupStocks.add(item);
      }
    }
    for (var item in allUnUseStocks) {
      if (item.contains(stock)) {
        unUseStocks.add(item);
      }
    }
    useStockKey.currentState!.upDateUsedStock(groupStocks);
    unUseStockkKey.currentState!.upDateUnUsedStock(unUseStocks);
  }

  return showDialog<String>(
    context: mainContext,
    barrierColor: rootColor['backdrop'],
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: rootColor['cardBg'],
      insetPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      titlePadding: const EdgeInsets.fromLTRB(25, 10, 25, 1),
      contentPadding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      // titlePadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      // contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      actionsPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
      titleTextStyle: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 16,
      ),
      title: Container(
        alignment: Alignment.centerLeft,
        child: const Text("????????????"),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: TextStyle(
                color: rootColor['mainFont'],
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: rootColor['lightBorder']!),
                ),
                hintText: "????????????????????????",
                hintStyle: TextStyle(
                  color: rootColor['placeholder'],
                  fontSize: 14
                )
              ),
              controller: stockController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              onChanged: (String val) {
                stock = val;
                filterStock();
              },
            ),
            BlocBuilder<UserBloc, UserState>(builder: (_, state) {
              useGroup = state.group.singleWhere((i) => i.id == groupId);
              allGroupStocks = List<String>.from(json.decode(json.encode(useGroup.codes)));
              groupStocks = allGroupStocks;
              return UsedStock(
                key: useStockKey,
                usedStock: groupStocks,
                removeCallBack: (String val) {
                  allGroupStocks.remove(val);
                  allUnUseStocks.add(val);
                  filterStock();
                  useStockKey.currentState!.upDateUsedStock(groupStocks);
                  unUseStockkKey.currentState!.upDateUnUsedStock(unUseStocks);
                }
              );
            }),
            BlocBuilder<StockBloc, StockState>(builder: (context, stockState) {
              allStocks = stockState.allStock;
              setUnUseStocks();
              return UnUsedStock(
                key: unUseStockkKey,
                unUsedStock: unUseStocks,
                addCallBack: (String val) {
                  allGroupStocks.add(val);
                  allUnUseStocks.remove(val);
                  filterStock();
                  useStockKey.currentState!.upDateUsedStock(groupStocks);
                  unUseStockkKey.currentState!.upDateUnUsedStock(unUseStocks);
                }
              );
            })
            
          ],
        )
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            "??????",
            style: TextStyle(
              color: rootColor['danger'],
              fontSize: 16,
            )
          ),
        ),
        TextButton(
            onPressed: () async {
              var res = await updateGroup(token, useGroup, allGroupStocks);
              if (res.code == 10000) {
                getGroup(mainContext, token);
                Navigator.pop(context, 'Cancel');
                showFlushbar('?????????????????????????????????', mainContext, 'success', '?????????????????????');
              } else {
                showFlushbar(res.message, mainContext, 'error', '?????????????????????');
              }
            },
            child: Text(
              "??????",
              style: TextStyle(
                color: rootColor['success'],
                fontSize: 16,
              )
            ),
          )
      ]
    )
  );
}

MyGroup filterFroupByCode(List<MyGroup> groups, int chooseGroup) {
  var chooseGroups = groups.singleWhere((item) => item.id == chooseGroup);
  if (chooseGroups != null) {
    return MyGroup.create();
  } else {
    return chooseGroups;
  }
}

bool checkStockInGroup(List<MyGroup> groups, int chooseGroup, String code) {
  var chooseGroups = groups.singleWhere((item) => item.id == chooseGroup);
  if (chooseGroups != null) {
    return false;
  } else {
    var thisCode = chooseGroups.codes.singleWhere((item) => item == code);
    if (thisCode != null) {
      return false;
    }
  }
  return true;
}

Widget subTitle(String main, String sub) {
  return Row(
    children: [
      Text(
        main,
        style: TextStyle(
          color: rootColor['mainFont'],
          fontWeight: FontWeight.bold,
        )
      ),
      Text(
        sub,
        style: TextStyle(
          color: rootColor['subFont'],
          fontSize: 14,
        ),
      ),
    ],
  );
}

ButtonStyle textButtonStyle() {
  return TextButton.styleFrom(
    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    alignment: Alignment.centerLeft
  );
}
          