
import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void logout(BuildContext context) async {
  final authBloc = BlocProvider.of<AuthBloc>(context);
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove("isLogin");
  authBloc.add(LogoutEvent());
  toPath(context, '/login');
}