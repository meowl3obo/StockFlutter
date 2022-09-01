import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class PaddingHr extends StatelessWidget {
  const PaddingHr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 7.0, 0, 7.0),
      child: Divider(
        color: rootColor['hr'], //#8092a3
        thickness: 2.0,
        indent: 20.0,
        endIndent: 20.0,
      ),
    );
  }
}

class Hr extends StatelessWidget {
  const Hr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: rootColor['hr'], //#8092a3
    );
  }
}