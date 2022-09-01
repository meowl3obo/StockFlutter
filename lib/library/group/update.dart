import 'package:flutter_application/infrastructure/group.dart';
import 'package:flutter_application/model/global.dart';
import 'package:flutter_application/model/stock.dart';

Future<ApiRes> createGroup(String token, String groupName, Map<String, String> codeMap) async {
  var codes = codeMap.keys.toList();
  var data = MyGroup(
    id: 0,
    group: groupName,
    codes: codes
  );

  var res = await createUserGroup(token, data);

  return res;
}

Future<ApiRes> updateGroup(String token, MyGroup group, List<String> codes) async {
  var copyGroup = MyGroup.fromJson(group.toJson());
  copyGroup.codes = codes;

  var res = await updateUserGroup(token, copyGroup);

  return res;
}

Future<ApiRes> addStockToGroup(String token, MyGroup group, String code) async {
  var copyGroup = MyGroup.fromJson(group.toJson());
  var haveCode = checkStockInGroup(copyGroup, code);
  if (haveCode) {
    copyGroup.codes.remove(code);
  } else {
    copyGroup.codes.add(code);
  }

  var res = await updateUserGroup(token, copyGroup);

  return res;
}

bool checkStockInGroup(MyGroup group, String code) {
  var thisCode = group.codes.singleWhere((item) => item == code);
  if (thisCode != null) {
    return false;
  }
  return true;
}