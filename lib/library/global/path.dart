import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

void toPath(BuildContext context, String path) {
  print(path);
  if (path.contains('faq')) {
    AutoRouter.of(context).pushNamed(path);
  } else {
    AutoRouter.of(context).replaceNamed(path);
  }
}