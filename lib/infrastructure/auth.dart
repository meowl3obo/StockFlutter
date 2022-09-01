import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/model/auth.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/infrastructure/http.dart';
import 'package:flutter_application/library/auth/response.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<ApiDataRes<LoginRes>> loginApi(TLogin loginBody) async {
  ApiDataRes<LoginRes> response = ApiDataRes<LoginRes>.create();
  var httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/auth/login');
  var res = await $http("POST", httpsUri, loginBody.toMap());

  response = loginResponse(res);

  return response;
}

Future<ApiDataRes<LoginRes>> thridLoginApi(TThirdLogin loginBody) async {
  ApiDataRes<LoginRes> response = ApiDataRes<LoginRes>.create();
  var httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/auth/login/thirdparty');
  var res = await $http("POST", httpsUri, loginBody.toMap());

  response = loginResponse(res);

  return response;
}

Future<ApiRes> registerApi(TRegister registerBody) async {
  ApiRes response;
  Uri httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/auth/register');
  var res = await $http("POST", httpsUri, registerBody.toMap());

  response = apiResponse(res);

  return response;
}

Future<ApiRes> forgetApi(String account) async {
  ApiRes response;
  Uri httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/auth/user/forgetpwd/req/$account');
  var res = await $http("POST", httpsUri);

  response = apiResponse(res);

  return response;
}

Future<ApiRes> updatePWDApi(String token, TLogin body) async {
  ApiRes response;
  Uri httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/auth/password/$token');
  var res = await $http("PUT", httpsUri, body.toMap());

  response = apiResponse(res);

  return response;
}

Future<ApiDataRes<LoginRes>> googleLogin() async {
  ApiDataRes<LoginRes> response = ApiDataRes<LoginRes>.create();

  GoogleSignIn google = GoogleSignIn(
    serverClientId: '593828383803-9l4n3ahlb5j45kth5nhjqkj239oohc12.apps.googleusercontent.com',
    scopes: [
      'profile email openid',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  var oauthRes;
  TThirdLogin loginReq;

  try {
    oauthRes = await google.signIn();
  } catch (e) {
    oauthRes = e;
  }
  if (oauthRes != null) {
    loginReq = TThirdLogin(account: "G${oauthRes.id}", email: oauthRes.email);
    response = await thridLoginApi(loginReq);
  }

  return response;
}

Future<ApiDataRes<LoginRes>> facebookLogin() async {
  ApiDataRes<LoginRes> response = ApiDataRes<LoginRes>.create();
  AccessToken? accessToken = await FacebookAuth.instance.accessToken;
  if (accessToken == null) {

    LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email', 'pages_show_list', 'pages_messaging', 'pages_manage_metadata'],
    );
    
    if (result.status != LoginStatus.success) {
      return response;
    }
  }
  var userData = await FacebookAuth.instance.getUserData();

  TThirdLogin loginReq;

  if (userData['email'] != '' && userData['id'] != '') {
    loginReq = TThirdLogin(account: "F${userData['id']}", email: userData['email']);
    response = await thridLoginApi(loginReq);
  }

  return response;
}
