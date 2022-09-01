import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> $http(String method, Uri uri, [Object? body]) async {
  Map<String, String> header = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };
  Object reqBody;
  print(body);
  if (body != null) {
    reqBody = json.encode(body);
  } else {
    reqBody = {};
  }
  
  Response response;

  switch (method) {
    case "GET":
      response = await http.get(uri, headers: header);
      break;
    case "POST":
      response = await http.post(uri, body: reqBody, headers: header);
      break;
    case "DELETE":
      response = await http.delete(uri, body: reqBody, headers: header);
      break;
    case "PUT":
      print(reqBody);
      response = await http.put(uri, body: reqBody, headers: header);
      break;
    default:
      Object errorBody = {
        "message": "http method error",
      };
      response = Response(errorBody.toString(), 0);
  }

  return response;
}