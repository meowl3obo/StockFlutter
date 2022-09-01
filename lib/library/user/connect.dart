import 'package:flutter_application/infrastructure/user.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/model/user.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

bool checkInput(String email, String chatID, String phone, String sendAction) {
  bool isEmpty = false;
  switch (sendAction) {
    case "email":
      isEmpty = email.isEmpty;
      break;
    case "telegram":
      isEmpty = chatID.isEmpty;
      break;
    case "phone":
      isEmpty = phone.isEmpty;
      break;
  }

  return isEmpty;
}

Future<ApiRes> storeConnectSetting(String token, String account, String email, String chatID, String phone, String sendAction, int rank) async {
  EasyLoading.show(status: 'loading...');
  ConnectData body = ConnectData(
    account: account,
    chatID: chatID,
    email: email,
    phone: phone,
    sendAction: sendAction,
    rank: rank
  );

  var res = await updateConnectSetting(token, body);
  EasyLoading.dismiss();

  return res;
}

Future<ApiRes> storeConnectStrategy(String token, Map<String, ConnectStrrategy> data) async {
  EasyLoading.show(status: 'loading...');
  List<Map<String, dynamic>> body = [];
  for (var key in data.keys.toList()) {
    ConnectStrrategy strategy = data[key]!;
    strategy.name = key;
    body.add(strategy.toMap());
  }

  var res = await updateConnectStrategy(token, body);
  EasyLoading.dismiss();

  return res;
}