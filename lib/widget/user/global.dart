import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class WCardTitle extends StatelessWidget {
  final String title;
  const WCardTitle({Key? key, required this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rootColor['border'],
      padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
      child: Text(
        title,
        style: TextStyle(
          color: rootColor['darkFont'],
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      )
    );
  }
}