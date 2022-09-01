import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class WSocialBtn extends StatelessWidget {
  final Color _bgColor;
  final Color _color;
  final VoidCallback _callBack;
  final String _text;
  final String _img;
  const WSocialBtn(
      {Key? key,
      required Color bgColor,
      required Color color,
      required VoidCallback callBack,
      required String text,
      required String img})
      : _bgColor = bgColor,
        _color = color,
        _callBack = callBack,
        _text = text,
        _img = img,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 00),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: _callBack,
          style: ElevatedButton.styleFrom(
            primary: _bgColor,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                _img,
                fit: BoxFit.cover,
                width: 30.0,
                height: 30.0,
              ),
              Text(
                _text,
                style: TextStyle(
                  color: _color,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600
                ),
              ),
            ]
          )
        )
      ),
    );
  }
}

class WOrHr extends StatelessWidget {
  final String _text;
  const WOrHr({Key? key, required String text}) : _text = text, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: rootColor['hr'], //#8092a3
              thickness: 2.0,
              endIndent: 4.0,
            ),
          ),
          Text(
            _text,
            style: TextStyle(
                color: rootColor['mainFont'],
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
          ),
          Expanded(
            child: Divider(
              color: rootColor['hr'], //#8092a3
              thickness: 2.0,
              indent: 4.0,
            )
          ),
        ],
      ),
    );
  }
}