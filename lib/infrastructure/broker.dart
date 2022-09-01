import 'dart:convert' as convert;
import 'package:flutter_application/infrastructure/http.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/model/broker.dart';
import 'package:flutter_application/model/global.dart';

Future<ApiDataRes<Map<String, List<String>>>> getBrokerList(Map<String, dynamic> query) async {
  ApiDataRes<Map<String, List<String>>> response = ApiDataRes<Map<String, List<String>>>.create();
  var resBody = <String, List<String>>{};
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/brokers',
      queryParameters: query
  );
  var res = await $http("GET", httpsUri);

  if (res.statusCode == 200) {
    var responseDynamic = Map.from(convert.jsonDecode(res.body));
    for (var key in responseDynamic.keys.toList()) {
      resBody[key.toString()] = List<String>.from(responseDynamic[key]);
    }
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}


Future<ApiDataRes<Map<String, List<BrokerData>>>> getUserBroker(String token) async {
  ApiDataRes<Map<String, List<BrokerData>>> response = ApiDataRes<Map<String, List<BrokerData>>>.create();
  var resBody = <String, List<BrokerData>>{};
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/brokers/$token',
  );
  var res = await $http("GET", httpsUri);

  if (res.statusCode == 200) {
    var responseDynamic = Map.from(convert.jsonDecode(res.body));
    for (var key in responseDynamic.keys.toList()) {
      resBody[key.toString()] = [];
      for (var item in List.from(responseDynamic[key])) {
        BrokerData brokerData = BrokerData.fromMap(item);
        resBody[key.toString()]!.add(brokerData);
      }
    }
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}

Future<ApiDataRes<Map<String, BrokerInOut>>> getBrokerInOut(String code, BrokerInOutReq body) async {
  ApiDataRes<Map<String, BrokerInOut>> response = ApiDataRes<Map<String, BrokerInOut>>.create();
  var resBody = <String, BrokerInOut>{};
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/brokers/trade/$code',
  );
  var res = await $http("POST", httpsUri, body.toMap());
  
  if (res.statusCode == 200) {
    var responseDynamic = Map.from(convert.jsonDecode(res.body));
    for (var key in responseDynamic.keys.toList()) {
      resBody[key.toString()] = BrokerInOut.fromMap(responseDynamic[key]);
    }
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}

Future<ApiDataRes<List<StockTrade>>> getTimeInOut(String code, BrokerInOutReq body) async {
  ApiDataRes<List<StockTrade>> response = ApiDataRes<List<StockTrade>>.create();
  List<StockTrade> resBody = [];
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/branch/trade/$code',
  );
  var res = await $http("POST", httpsUri, body.toMap());
  
  if (res.statusCode == 200) {
    var responseDynamic = List.from(convert.jsonDecode(res.body));
    for (var item in responseDynamic) {
      resBody.add(StockTrade.fromMap(item));
    }
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}

Future<ApiDataRes<List<BrokerInOutDetails>>> getBrokerInOutDetails(String code, BrokerInOutDetailsReq body) async {
  ApiDataRes<List<BrokerInOutDetails>> response = ApiDataRes<List<BrokerInOutDetails>>.create();
  List<BrokerInOutDetails> resBody = [];
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/broker/priceinfo/$code',
  );
  var res = await $http("POST", httpsUri, body.toMap());
  
  if (res.statusCode == 200) {
    var responseDynamic = List.from(convert.jsonDecode(res.body));
    for (var item in responseDynamic) {
      resBody.add(BrokerInOutDetails.fromMap(item));
    }
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}

Future<ApiRes> createMyBroker(String token, String myBrokerName, List<BrokerData> body) async {
  ApiRes response = ApiRes.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/broker/$token',
      queryParameters: { "ruleName": myBrokerName }
  );
  List<Map<String, String>> reqBody = [];
  for (var item in body) {
    reqBody.add(item.toMap().map((key, value) => MapEntry(key, value.toString())));
  }
  var res = await $http("PUT", httpsUri, body);

  response = apiResponse(res);
  print(res.statusCode);
  print(response.code);
  print(response.message);

  return response;
}
