import 'package:flutter/material.dart';
import 'package:flutter_application/application/stock/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);
  
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: rootColor['transparent'],
            highlightColor: rootColor['transparent'],
            onTap: () { toPath(context, '/'); },
            child: Image.asset('assets/header.png'),
          ),
          Column(
            children: [
              const Text(
                "最後更新",
                style: TextStyle(
                  fontSize: 16
                ),
              ),
              BlocBuilder<StockBloc, StockState>(builder: (context, state) {
                return Text(
                  state.lastTradingDay,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                );
              }),
            ],
          )
        ],
      ),
      backgroundColor: rootColor['bgColor'], // #141c24
    );
  }
}