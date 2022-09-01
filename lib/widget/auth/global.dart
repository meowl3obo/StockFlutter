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
          fontSize: 32.0,
        ),
      ),
    );
  }
}

class WLabel extends StatelessWidget {
  final String _text;
  const WLabel({Key? key, required String text}) : _text = text, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _text,
        style: TextStyle(
            color: rootColor['mainFont'],
            fontSize: 16.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

class WLabelInput extends StatelessWidget {
  final TextEditingController _controller;
  final Function(String) _onChange;
  final bool _obscureText;
  final String _text;
  const WLabelInput({Key? key, required TextEditingController controller, required Function(String) onChange, required bool obscureText, required String text}) : 
    _controller = controller,
    _onChange = onChange,
    _obscureText = obscureText,
    _text = text,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
        ),
        WLabel(text: _text),
        WInput(
          controller: _controller,
          obscureText: _obscureText,
          onChange: _onChange
        ),
      ],
    );
  }
}

class WInput extends StatelessWidget {
  final TextEditingController _controller;
  final Function(String) _onChange;
  final bool _obscureText;
  const WInput({Key? key, required TextEditingController controller, required Function(String) onChange, required bool obscureText}) : 
    _controller = controller,
    _onChange = onChange,
    _obscureText = obscureText,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.text,
      obscureText: _obscureText,
      maxLines: 1,
      style: TextStyle(
        color: rootColor['mainFont'],
      ),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: rootColor['lightBorder']!,
          ),
        ),
      ),
      onChanged: _onChange,
    );
  }
}