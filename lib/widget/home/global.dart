import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class WMainTh extends StatelessWidget {
  final String _title;
  final Function() _onTap;
  final bool _useSort;
  const WMainTh({ Key? key, required String title, required Function() onTap, required bool useSort }) : _title = title, _onTap = onTap, _useSort = useSort, super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          color: rootColor['tableThead'],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _title,
                    style: TextStyle(
                      color: rootColor['mainFont'],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  if (_useSort) Icon(
                    Icons.sort,
                    color: rootColor['mainFont'],
                    size: 22.0,
                  )
                ],
              )
            )
          ),
        ),
      )
    );
  }
}
class WSubTh extends StatelessWidget {
  final String _title;
  final Function() _onTap;
  final bool _useSort;
  const WSubTh({ Key? key, required String title, required Function() onTap, required bool useSort }) : _title = title, _onTap = onTap, _useSort = useSort, super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          color: rootColor['tableSubThead'],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _title,
                    style: TextStyle(
                      color: rootColor['darkFont'],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  if (_useSort) Icon(
                    Icons.sort,
                    color: rootColor['darkFont'],
                    size: 20.0,
                  )
                ],
              )
            )
          ),
        ),
      )
    );
  }
}

class SettingTitle extends StatelessWidget {
  final String title;
  const SettingTitle({Key? key, required this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.settings,
            color: rootColor['mainFont'],
          size: 30.0,
        ),
        const SizedBox(width: 7),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: rootColor['mainFont']
          )
        )
      ],
    );
  }
}