import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/config/error_api_map.dart';
import 'package:flutter_application/library/auth/logout.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/model/global.dart';
import 'package:http/http.dart';

ApiRes apiResponse(Response  res) {
  ApiRes response;
  if (res.statusCode == 200) {
    response = ApiRes.fromJson(res.body);
  } else if (res.statusCode == 0) {
    response = ApiRes( code: 0, message: res.body);
  } else  {
    var body = json.decode(res.body);
    if (body is Map) {
      if (body['Error'].toString().contains('Login time out!')) {
        response = ApiRes( code: 50000, message: "登入超時，請重新登入");
      } else if (body['Error'].toString().contains('timeout')) {
        response = ApiRes( code: 50100, message: "等候逾時");
      } else if (body['Error'].toString().contains('所選日期超出範圍')) {
        response = ApiRes( code: 50200, message: "所選日期超出範圍");
      } else if (body['Error'].toString().contains('查詢數量')) {
        response = ApiRes( code: 50300, message: "已達每日查詢次數");
      } else if (body['Error'].toString().contains('所選日期沒有資料')) {
        response = ApiRes( code: 50400, message: "所選日期沒有資料");
      } else {
        response = ApiRes( code: res.statusCode, message: "伺服器錯誤");
      }
    } else {
      response = ApiRes( code: res.statusCode, message: "伺服器錯誤");
    }
  }

  return response;
}

int getApiErrorMsg(Response  res) {
  int code = 50000;
  var body = json.decode(res.body);
   if (body is Map) {
    if (body['Error'].toString().contains('Login time out!')) {
      code = 50100;
    } else if (body['Error'].toString().contains('timeout')) {
      code = 50200;
    } else if (body['Error'].toString().contains('所選日期超出範圍')) {
      code = 50300;
    } else if (body['Error'].toString().contains('查詢數量')) {
      code = 50400;
    } else if (body['Error'].toString().contains('所選日期沒有資料')) {
      code = 50500;
    }
  }

  return code;
}

void apiErrorAction(int code, String title, BuildContext context) {
  if (code != 10000) {
    showFlushbar(apiErrorMap[code]!, context, 'error', title);
    if (code == 50100) {
      logout(context);
    }
  }
}