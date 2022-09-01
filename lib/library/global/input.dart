import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

InputDecoration inputUnderLineStyle() {
  return InputDecoration(
    isCollapsed: true,
    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: rootColor['border']!,
      )
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: rootColor['border']!,
      )
    )
  );             
}