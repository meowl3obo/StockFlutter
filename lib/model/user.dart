import 'dart:convert';

class ConnectData {
  ConnectData({
    required this.account,
    required this.chatID,
    required this.email,
    required this.phone,
    required this.sendAction,
    required this.rank,
  });

  String account;
  String chatID;
  String email;
  String phone;
  String sendAction;
  int rank;

  factory ConnectData.fromJson(String str) => ConnectData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConnectData.fromMap(Map<String, dynamic> json) => ConnectData(
    account: json["account"],
    chatID: json["chatID"],
    email: json["email"],
    phone: json["phone"],
    sendAction: json["sendAction"],
    rank: json["rank"],
  );

  Map<String, dynamic> toMap() => {
    "account": account,
    "chatID": chatID,
    "email": email,
    "phone": phone,
    "sendAction": sendAction,
    "rank": rank,
  };

  factory ConnectData.create() => ConnectData(
    account: "",
    chatID: "",
    email: "",
    phone: "",
    sendAction: "",
    rank: 0
  );
}

class ConnectStrrategy {
  ConnectStrrategy({
    required this.filterMarket,
    required this.industry,
    required this.firstMatch,
    required this.id,
    required this.needSend,
    this.name
  });

  String filterMarket;
  String industry;
  int firstMatch;
  int id;
  int needSend;
  String? name;
  

  factory ConnectStrrategy.fromJson(String str) => ConnectStrrategy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConnectStrrategy.fromMap(Map<String, dynamic> json) => ConnectStrrategy(
    filterMarket: json["filterMarket"],
    industry: json["industry"],
    firstMatch: json["firstMatch"],
    id: json["id"],
    needSend: json["needSend"],
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "filterMarket": filterMarket,
    "industry": industry,
    "firstMatch": firstMatch,
    "id": id,
    "needSend": needSend,
    "name": name,
  };

  factory ConnectStrrategy.create() => ConnectStrrategy(
    filterMarket: "",
    industry: "",
    firstMatch: -1,
    id: -1,
    needSend: 0,
  );
}