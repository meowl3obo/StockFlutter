import 'dart:convert' as convert;
import 'package:flutter_application/infrastructure/http.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/model/user.dart';

Future<ApiDataRes<ConnectData>> getConnectSetting(String token) async {
  ApiDataRes<ConnectData> response = ApiDataRes<ConnectData>.create();
  ConnectData resBody = ConnectData.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/auth/users/settings/$token',
  );
  var res = await $http("GET", httpsUri);

  if (res.statusCode == 200) {
    resBody = ConnectData.fromJson(res.body);
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}

Future<ApiRes> updateConnectSetting(String token, ConnectData body) async {
  ApiRes response = ApiRes.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/auth/users/settings/$token',
  );
  var res = await $http("PUT", httpsUri, body.toMap());

  response = apiResponse(res);

  return response;
}

Future<ApiDataRes<Map<String, ConnectStrrategy>>> getConnectStrategy(String token) async {
  ApiDataRes<Map<String, ConnectStrrategy>> response = ApiDataRes<Map<String, ConnectStrrategy>>.create();
  Map<String, ConnectStrrategy> resBody = {};
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/favoriterule/settings/send/$token',
  );
  var res = await $http("GET", httpsUri);

  if (res.statusCode == 200) {
    var responseDynamic = Map.from(convert.jsonDecode(res.body));
    for (var key in responseDynamic.keys.toList()) {
      resBody[key.toString()] = ConnectStrrategy.fromMap(responseDynamic[key]);
    }
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}

Future<ApiRes> updateConnectStrategy(String token, List<Map<String, dynamic>> body) async {
  ApiRes response = ApiRes.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/favoriterule/settings/$token',
  );

  var res = await $http("PUT", httpsUri, body);

  response = apiResponse(res);

  return response;
}