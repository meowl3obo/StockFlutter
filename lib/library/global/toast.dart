
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

Map<String, String> typeColorMap = {
  "success": "hintSuccess",
  "error": "hintDanger",
  "warning": "hintWarning"
};

void showToast(String text, BuildContext context, String type) {
  var snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 16.0),
      ),
      backgroundColor: rootColor[typeColorMap[type]]);

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showFlushbar(String text, BuildContext context, String type, [String? title]) {
  var flush = Flushbar(
    title: title,
    flushbarPosition: FlushbarPosition.BOTTOM,
    message: text,
    backgroundColor: rootColor[typeColorMap[type]]!,
    duration: const Duration(seconds: 3),
  );

  flush.show(context);
}
