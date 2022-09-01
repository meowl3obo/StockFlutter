import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class WTitle extends StatelessWidget {
  final String _text;
  const WTitle({Key? key, required String text}) : _text = text,  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _text,
        style: TextStyle(
          color: rootColor['mainFont'],
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
      ),
    );
  }
}

class WItem extends StatelessWidget {
  final String _text;
  final Function() _onPreesed;
  const WItem({Key? key, required String text, required Function() onPressed}) : _text = text, _onPreesed = onPressed, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: _onPreesed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        ),
        child: Row(
          children: <Widget>[
            Text(
              _text,
              style: TextStyle(
                color: rootColor['mainFont'],
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.arrow_circle_right_outlined,
              color: rootColor['mainFont'],
              size: 24.0,
            ),
          ],
        )
      ),
    );
  }
}