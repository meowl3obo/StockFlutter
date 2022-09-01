import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class WPrePage extends StatelessWidget {
  const WPrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () { AutoRouter.of(context).pop(); },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.arrow_circle_left_outlined,
                color: rootColor['mainFont'],
                size: 24.0,
              ),
              const SizedBox(width: 5, height: 0),
              Text(
                "上一頁",
                style: TextStyle(
                  color: rootColor['mainFont'],
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
