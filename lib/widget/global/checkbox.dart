
import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class CheckboxItem extends StatefulWidget {
  final String title;
  final Function(bool) onChange;
  bool value;

  CheckboxItem({Key? key, required this.title, required this.onChange, required this.value}) : super(key: key);

  @override
  CheckboxItemState createState() => CheckboxItemState();
}

class CheckboxItemState extends State<CheckboxItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setValue(bool newValue) {
    setState(() { widget.value = newValue; });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          side: BorderSide(color: rootColor['mainFont']!),
          onChanged: (val) {
            setState(() {
              widget.value = !widget.value;
            });
            widget.onChange(widget.value);
          },
          value: widget.value
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              setState(() {
                widget.value = !widget.value;
              });
              widget.onChange(widget.value);
            },
            child: Text(widget.title,
              style: TextStyle(
                color: rootColor['mainFont'],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ),
          )
        )
      ],
    );
  }
}

class CheckboxItemNotBoldAndLeft extends StatefulWidget {
  final String title;
  final Function(bool) onChange;
  bool value;

  CheckboxItemNotBoldAndLeft({Key? key, required this.title, required this.onChange, required this.value}) : super(key: key);

  @override
  CheckboxItemNotBoldAndLeftState createState() => CheckboxItemNotBoldAndLeftState();
}

class CheckboxItemNotBoldAndLeftState extends State<CheckboxItemNotBoldAndLeft> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setValue(bool newValue) {
    setState(() { widget.value = newValue; });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: <Widget>[
          Checkbox(
            side: BorderSide(color: rootColor['mainFont']!),
            onChanged: (val) {
              setState(() {
                widget.value = !widget.value;
              });
              widget.onChange(widget.value);
            },
            value: widget.value
          ),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft
              ),
              onPressed: () {
                setState(() {
                  widget.value = !widget.value;
                });
                widget.onChange(widget.value);
              },
              child: Text(widget.title,
                style: TextStyle(
                  color: rootColor['mainFont'],
                  fontSize: 16,
                )
              ),
            )
          )
        ],
      ),
    );
  }
}