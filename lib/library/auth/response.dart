import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/model/auth.dart';
import 'package:flutter_application/model/global.dart';
import 'package:http/http.dart';

ApiDataRes<LoginRes> loginResponse(Response  res) {
  ApiDataRes<LoginRes> response = ApiDataRes<LoginRes>.create();
  LoginRes resBody;

  if (res.statusCode == 200) {
    resBody = LoginRes.fromJson(res.body);
  } else if (res.statusCode == 0) {
    response.code = getApiErrorMsg(res);
    resBody = LoginRes( code: 0, message: res.body, token: "", email: "", account: "", rank: 0, );
  } else  {
    response.code = getApiErrorMsg(res);
    resBody = LoginRes( code: res.statusCode, message: "api error", token: "", email: "", account: "", rank: 0, );
  }

  response.body = resBody;

  return response;
}