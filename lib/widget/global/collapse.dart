import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class Collapse extends StatefulWidget {
  final Widget content;
  final Widget header;
  Collapse({Key? key, required this.content, required this.header}) : super(key: key);

  @override
  CollapseState createState() => CollapseState();
}

class CollapseState extends State<Collapse> {
  final ExpandableController expController = ExpandableController(initialExpanded: false);

  void closeCollapse() {
    setState(() {
      expController.expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: rootColor['mainFont'],
        iconSize: 24.0
      ),
      child: ExpandablePanel(
        controller: expController,
        header: widget.header,
        collapsed: const SizedBox(),
        expanded: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 180
          ),
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              child: widget.content
            ),
          )
        )
      )
    );
  }
}