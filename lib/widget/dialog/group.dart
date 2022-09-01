
import 'package:flutter/material.dart';
import 'package:flutter_application/application/stock/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/library/group/dialog.dart';
import 'package:flutter_application/model/stock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSelect extends StatefulWidget {
  late int chooseGroup;
  final List<MyGroup> group;
  final String code;
  final Function(int) callBack;
  GroupSelect({Key? key, required this.chooseGroup, required this.group, required this.callBack, required this.code}) : super(key: key);

  @override
  GroupSelectState createState() => GroupSelectState();
}

class GroupSelectState extends State<GroupSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: const EdgeInsets.only(top: 10.0),
      height: 30.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: rootColor['lightBorder']!
        )
      ),
      child: DropdownButton(
        itemHeight: 48.0,
        isExpanded: true,
        value: widget.chooseGroup,
        dropdownColor: rootColor['cardBg'],
        underline: const SizedBox(),
        onChanged: (int? value) {
          setState(() {
            widget.chooseGroup = value!;
          });
          widget.callBack(value!);
        },
        items: widget.group.map<DropdownMenuItem<int>>((item) => DropdownMenuItem<int>(
            value: item.id,
            child: Text(
              "${item.group} ${item.codes.contains(widget.code) ? '(已選)' : ''}",
              style: TextStyle(
                color: rootColor['mainFont']
              )
            )
          )
        ).toList(),
      )
    );
  }
}

class StockSelect extends StatefulWidget {
  late Map<String, String> allStockMap;
  final Function(String) chooseCallBack;
  StockSelect({Key? key, required this.chooseCallBack, required this.allStockMap}) : super(key: key);

  @override
  StockSelectState createState() => StockSelectState();
}

class StockSelectState extends State<StockSelect> {
  final TextEditingController stockController = TextEditingController();
  late Map<String, String> filterStockMap = {};
  late String chooseStock = '';

  void reSetAllStockMap(Map<String, String> allStockMap) {
    widget.allStockMap = allStockMap;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: TextStyle(
            color: rootColor['mainFont'],
          ),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: rootColor['lightBorder']!),
            ),
          ),
          controller: stockController,
          keyboardType: TextInputType.text,
          maxLines: 1,
          onChanged: (String val) {
            setState(() { 
              filterStockMap = {};
              chooseStock = val; 
              widget.allStockMap.keys.toList().forEach((item) {
                if (item.contains(val) || widget.allStockMap[item]!.contains(val)) {
                  filterStockMap[item] = widget.allStockMap[item]!;
                }
              });
            });
          },
        ),
        if (chooseStock.length >= 2) ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 140),
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var item in filterStockMap.keys.toList()) TextButton(
                    style: textButtonStyle(),
                    onPressed: () {
                      setState(() { 
                        chooseStock = '';
                        stockController.clear();
                      });
                      widget.chooseCallBack(item);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: rootColor['success'],
                          size: 16.0,
                        ),
                        Text(
                          "$item - ${filterStockMap[item]}",
                          style: TextStyle(color: rootColor['mainFont'])
                        )
                      ]
                    ),
                  )
                ],
              )
            ),
          )
        )
      ],
    );
  }
}

class ChoosedStock extends StatefulWidget {
  late Map<String, String> choosedStockMap;
  final Function(String) deleteCallBack;
  ChoosedStock({Key? key, required this.choosedStockMap, required this.deleteCallBack}) : super(key: key);

  @override
  ChoosedStockState createState() => ChoosedStockState();
}

class ChoosedStockState extends State<ChoosedStock> {
  void reSetChoosedStockMap(Map<String, String> choosedStockMap) {
    setState(() {
      widget.choosedStockMap = choosedStockMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 140),
      child: IntrinsicHeight(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var item in widget.choosedStockMap.keys.toList()) TextButton(
                style: textButtonStyle(),
                onPressed: () {
                  widget.deleteCallBack(item);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: rootColor['danger'],
                      size: 16.0,
                    ),
                    Text(
                      "$item - ${widget.choosedStockMap[item]}",
                      style: TextStyle(color: rootColor['mainFont'])
                    )
                  ]
                ),
              )
            ],
          )
        ),
      )
    );
  }
}

class UsedStock extends StatefulWidget {
  late List<String> usedStock;
  final Function(String) removeCallBack;
  UsedStock({Key? key, required this.usedStock, required this.removeCallBack}): super(key: key);

  @override
  UsedStockState createState() => UsedStockState();
}

class UsedStockState extends State<UsedStock> {
  void upDateUsedStock(List<String> usedStock) {
    setState(() {
      widget.usedStock = usedStock;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width/1.3,
        maxHeight: 140
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
        decoration: BoxDecoration(
          border: Border.all(color: rootColor['border']!)
        ),
        child: IntrinsicHeight(
          child: SingleChildScrollView(
            child: BlocBuilder<StockBloc, StockState>(builder: (context, state) {
              return Column(
                children: [
                  for (var item in widget.usedStock) TextButton(
                    style: textButtonStyle(),
                    onPressed: () { widget.removeCallBack(item); },
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_outlined,
                          color: rootColor['warning'],
                          size: 16.0,
                        ),
                        Text(
                          "$item - ${state.allStock[item]}",
                          style: TextStyle(
                            color: rootColor['mainFont']
                          ),
                        )
                      ],
                    )
                  )
                ],
              );
            }),
          ),
        ),
      )
    );
  }
}

class UnUsedStock extends StatefulWidget {
  late List<String> unUsedStock;
  final Function(String) addCallBack;
  UnUsedStock({Key? key, required this.unUsedStock, required this.addCallBack}): super(key: key);

  @override
  UnUsedStockState createState() => UnUsedStockState();
}

class UnUsedStockState extends State<UnUsedStock> {
  late ScrollController controller;
  late int showMax = 20;
  late List<String> showUnUsedStock = widget.unUsedStock.getRange(0, showMax).toList();
  void upDateUnUsedStock(List<String> unUsedStock) {
    setState(() {
      widget.unUsedStock = unUsedStock;
      if (showMax > widget.unUsedStock.length) {
        showUnUsedStock = widget.unUsedStock.getRange(0, widget.unUsedStock.length).toList();
      } else {
        showUnUsedStock = widget.unUsedStock.getRange(0, showMax).toList();
      }
    });
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 500) {
      showMax += 20;
      setState(() {
        if (showMax > widget.unUsedStock.length) {
          showUnUsedStock = widget.unUsedStock.getRange(0, widget.unUsedStock.length).toList();
        } else {
          showUnUsedStock = widget.unUsedStock.getRange(0, showMax).toList();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:  BoxConstraints(
        minWidth: MediaQuery.of(context).size.width/2,
        maxHeight: 140
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
        decoration: BoxDecoration(
          border: Border.all(color: rootColor['border']!)
        ),
        child: IntrinsicHeight(
          child: SingleChildScrollView(
            controller: controller,
            child: BlocBuilder<StockBloc, StockState>(builder: (context, state) {
              return Column(
                children: [
                  for (var item in showUnUsedStock) TextButton(
                    style: textButtonStyle(),
                    onPressed: () { widget.addCallBack(item); },
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_outline,
                          color: rootColor['warning'],
                          size: 16.0,
                        ),
                        Text(
                          "$item - ${state.allStock[item]}",
                          style: TextStyle(
                            color: rootColor['mainFont']
                          ),
                        )
                      ],
                    )
                  )
                ],
              );
            }),
          ),
        ),
      )
    );
  }
}
