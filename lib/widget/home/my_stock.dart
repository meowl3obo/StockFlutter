import 'package:flutter/material.dart';
import 'package:flutter_application/application/user/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/library/group/dialog.dart';
import 'package:flutter_application/widget/global/collapse.dart';
import 'package:flutter_application/widget/home/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlGroup extends StatefulWidget {
  late int chooseGroup = 0;
  ControlGroup({Key? key}): super(key: key);

  @override
  ControlGroupState createState() => ControlGroupState();
}

class ControlGroupState extends State<ControlGroup> {
  void updateChooseGroup(int chooseGroup) {
    setState(() {
      widget.chooseGroup = chooseGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.chooseGroup > 0) OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 1.0, color: rootColor['hr']!),
            ),
            onPressed: () => { showUpdateGroupDialog(context, widget.chooseGroup) },
            child: Text(
              "增刪股票",
              style: TextStyle(
                color: rootColor['mainFont'],
                fontSize: 16                           
              ),
            )
          ),
          if (widget.chooseGroup > 0) const SizedBox(width: 5),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 1.0, color: rootColor['hr']!),
            ),
            onPressed: () { showCreateGroupDialog(context); },
            child: Text(
              "新增群組",
              style: TextStyle(
                color: rootColor['mainFont'],
                fontSize: 16                           
              ),
            )
          )
        ],
      ),
    );
  }
}

class ChooseGroup extends StatefulWidget {
  final Function(List<String>, int) callBack;
  const ChooseGroup({Key? key, required this.callBack}): super(key: key);

  @override
  ChooseGroupState createState() => ChooseGroupState();
}

class ChooseGroupState extends State<ChooseGroup> {
  final GlobalKey<CollapseState> collapseKey = GlobalKey<CollapseState>();
  late int chooseGroup = -1;
  late List<String> chooseStocks = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
      child: Collapse(
        key: collapseKey,
        header: const SettingTitle(title: "請選擇自選股群組"),
        content: BlocBuilder<UserBloc, UserState>(builder: (_, state) {
          return Theme(
            data: ThemeData(
              unselectedWidgetColor: rootColor['lightBorder'],
            ),
            child: Column(
              children: [
                for (var item in state.group) SizedBox(
                  height: 36,
                  child: Row(
                  children: [
                    Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: item.id,
                      groupValue: chooseGroup,
                      onChanged: (int? value) {
                        setState(() {
                          chooseGroup = value!;
                          chooseStocks = item.codes;
                        });
                        collapseKey.currentState!.closeCollapse();
                        widget.callBack(item.codes, item.id);
                      },
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            chooseGroup = item.id;
                          chooseStocks = item.codes;
                          });
                          collapseKey.currentState!.closeCollapse();
                          widget.callBack(item.codes, item.id);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.group,
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
        }),
      )
    );
  }
}