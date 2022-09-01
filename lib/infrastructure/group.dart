import 'dart:convert' as convert;
import 'package:flutter_application/infrastructure/http.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/model/stock.dart';

Future<ApiDataRes<List<MyGroup>>> getUserGroup(String token) async {
  ApiDataRes<List<MyGroup>> response = ApiDataRes<List<MyGroup>>.create();
  List<MyGroup> resBody = [];
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/favoritestocks/$token',
  );
  var res = await $http("GET", httpsUri);
  
  if (res.statusCode == 200) {
    List<dynamic> deCodeRes = convert.jsonDecode(res.body);
    for (var item in deCodeRes) {
      resBody.add(MyGroup.fromMap(item));
    }
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;
  return response;
}

Future<ApiRes> createUserGroup(String token, MyGroup body) async {
  ApiRes response = ApiRes.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/favoritestock/$token',
  );
  var res = await $http("POST", httpsUri, body.toMap());

  response = apiResponse(res);

  return response;
}

Future<ApiRes> updateUserGroup(String token, MyGroup body) async {
  ApiRes response = ApiRes.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/favoritestock/$token',
  );
  var res = await $http("PUT", httpsUri, body.toMap());

  response = apiResponse(res);

  return response;
}