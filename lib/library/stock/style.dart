
import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

Color checkUpDown(num price) {
  return price > 0 ? rootColor['danger']! : price < 0 ? rootColor['success']! : rootColor['mainFont']!;
}