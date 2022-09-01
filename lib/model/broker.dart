
import 'dart:convert';

class BrokerData {
  BrokerData({
    required this.first,
    required this.second,
  });

  String first;
  String second;

  factory BrokerData.fromJson(String str) => BrokerData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrokerData.fromMap(Map<String, dynamic> json) => BrokerData(
    first: json["first"] ?? "",
    second: json["second"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "first": first,
    "second": second,
  };

  factory BrokerData.create(Map<String, dynamic> json) => BrokerData(
    first: "",
    second: "",
  );
}

class BrokerInOutReq {
  BrokerInOutReq({
    required this.broker,
    required this.code,
    required this.endDate,
    required this.startDate,
    required this.token,
  });

  List<String> broker;
  String code;
  String endDate;
  String startDate;
  String token;

  factory BrokerInOutReq.fromJson(String str) => BrokerInOutReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrokerInOutReq.fromMap(Map<String, dynamic> json) => BrokerInOutReq(
    broker: json["broker"] == null ? [] : List<String>.from(json["broker"]),
    code: json["code"],
    endDate: json["endDate"],
    startDate: json["startDate"],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "broker": List<String>.from(broker),
    "code": code,
    "endDate": endDate ,
    "startDate": startDate,
    "token": token ,
  };
}

class BrokerInOutDetailsReq {
  BrokerInOutDetailsReq({
    required this.broker,
    required this.code,
    required this.endDate,
    required this.startDate,
    required this.token,
    required this.price
  });

  List<String> broker;
  String code;
  String endDate;
  String startDate;
  String token;
  num price;

  factory BrokerInOutDetailsReq.fromJson(String str) => BrokerInOutDetailsReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrokerInOutDetailsReq.fromMap(Map<String, dynamic> json) => BrokerInOutDetailsReq(
    broker: json["broker"] == null ? [] : List<String>.from(json["broker"]),
    code: json["code"],
    endDate: json["endDate"],
    startDate: json["startDate"],
    token: json["token"],
    price: json["price"]
  );

  Map<String, dynamic> toMap() => {
    "broker": List<String>.from(broker),
    "code": code,
    "endDate": endDate,
    "startDate": startDate,
    "token": token,
    "price": price
  };
}

class BrokerInOut {
  BrokerInOut({
    required this.closePrice,
    required this.yesterdayClosePrice,
    required this.stockTrades,
  });

  num closePrice;
  num yesterdayClosePrice;
  List<StockTrade> stockTrades;

  factory BrokerInOut.fromJson(String str) => BrokerInOut.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrokerInOut.fromMap(Map<String, dynamic> json) => BrokerInOut(
    closePrice: json["closePrice"],
    yesterdayClosePrice: json["yesterdayClosePrice"],
    stockTrades: json["stockTrades"] == null ? [] : List<StockTrade>.from(json["stockTrades"].map((x) => StockTrade.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "closePrice": closePrice,
    "yesterdayClosePrice": yesterdayClosePrice ,
    "stockTrades": List<dynamic>.from(stockTrades.map((x) => x.toMap())),
  };
}

class StockTrade {
  StockTrade({
    required this.price,
    required this.buy,
    required this.sell,
    required this.subData,
    required this.brokers,
  });

  num price;
  num buy;
  num sell;
  num subData;
  List<String> brokers;

  factory StockTrade.fromJson(String str) => StockTrade.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockTrade.fromMap(Map<String, dynamic> json) => StockTrade(
    price: json["price"],
    buy: json["buy"],
    sell: json["sell"],
    subData: json["subData"],
    brokers: json["brokers"] == null ? [] : List<String>.from(json["brokers"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "price": price,
    "buy": buy,
    "sell": sell,
    "subData": subData,
    "brokers": List<dynamic>.from(brokers.map((x) => x)),
  };
}

class BrokerInOutDetails {
  BrokerInOutDetails({
    required this.branch,
    required this.broker,
    required this.buy,
    required this.sell,
  });

  String branch;
  String broker;
  num buy;
  num sell;

  factory BrokerInOutDetails.fromJson(String str) => BrokerInOutDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  
  factory BrokerInOutDetails.fromMap(Map<String, dynamic> json) => BrokerInOutDetails(
    broker: json["broker"],
    branch: json["branch"],
    buy: json["buy"],
    sell: json["sell"],
  );

  Map<String, dynamic> toMap() => {
    "broker": broker,
    "branch": branch ,
    "buy": buy,
    "sell": sell ,
  };
}
