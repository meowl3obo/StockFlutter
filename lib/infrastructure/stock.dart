import 'dart:convert' as convert;
import 'package:flutter_application/infrastructure/http.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/model/stock.dart';
import 'package:intl/intl.dart';

Future<ApiDataRes<String>> getLastTranding() async {
  ApiDataRes<String> response = ApiDataRes<String>.create();
  var resBody = "";
  var httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/stock/lasttradingday');
  var res = await $http("GET", httpsUri);

  if (res.statusCode == 200) {
    resBody = res.body;
  } else {
    response.code = getApiErrorMsg(res);
    DateTime now = DateTime.now();
    resBody = DateFormat('MM-dd').format(now);
  }

  response.body = resBody;

  return response;
}

Future<ApiDataRes<List<String>>> getIndustrys() async {
  ApiDataRes<List<String>> response = ApiDataRes<List<String>>.create();
  List<String> resBody = [];
  var httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/stock/industrys');
  var res = await $http("GET", httpsUri);

  if (res.statusCode == 200) {
    resBody = List.from(convert.jsonDecode(res.body));
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}


Future<ApiDataRes<Map<String, String>>> getAllStock() async {
  ApiDataRes<Map<String, String>> response = ApiDataRes<Map<String, String>>.create();
  var resBody = <String, String>{};
  var httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/stock/brokers/map');
  var res = await $http("GET", httpsUri);

  if (res.statusCode == 200) {
    resBody = Map.from(convert.jsonDecode(res.body));
    resBody = Map.fromEntries(resBody.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}

Future<ApiDataRes<StockData>> getWarningStock() async {
  ApiDataRes<StockData> response = ApiDataRes<StockData>.create();
  StockData resBody = StockData.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/stockdata/warning',
      queryParameters: { "mobile": "true" }
  );
  var res = await $http("GET", httpsUri);
  
  if (res.statusCode == 200) {
    resBody = StockData.fromJson(res.body);
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}

Future<ApiDataRes<StockInfoDetails>> getStockInfo(String code) async {
  ApiDataRes<StockInfoDetails> response = ApiDataRes<StockInfoDetails>.create();
  StockInfoDetails resBody = StockInfoDetails.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/stockdata/$code',
  );
  var res = await $http("GET", httpsUri);
  
  if (res.statusCode == 200) {
    resBody = StockInfoDetails.fromJson(res.body);
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;
  return response;
}

Future<ApiDataRes<StockInfoDetails>> getWarningStockInfo(String code) async {
  ApiDataRes<StockInfoDetails> response = ApiDataRes<StockInfoDetails>.create();
  StockInfoDetails resBody = StockInfoDetails.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/stockdata/warning/$code',
  );
  var res = await $http("GET", httpsUri);
  
  if (res.statusCode == 200) {
    resBody = StockInfoDetails.fromJson(res.body);
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;
  return response;
}

Future<ApiDataRes<StockData>> getMultipleStock(String token, List<String> codes) async {
  ApiDataRes<StockData> response = ApiDataRes<StockData>.create();
  StockData resBody = StockData.create();
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/stockdata/codes',
      queryParameters: { "mobile": "true", "token": token }
  );
  var res = await $http("POST", httpsUri, codes);
  
  if (res.statusCode == 200) {
    resBody = StockData.fromJson(res.body);
  } else {
    response.code = getApiErrorMsg(res);
  }

  response.body = resBody;

  return response;
}
