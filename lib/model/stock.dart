import 'dart:convert';

class StockData {
  StockData({
    required this.date,
    required this.stockInfo,
  });

  String date;
  List<StockInfo> stockInfo;

  factory StockData.fromJson(String str) => StockData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockData.fromMap(Map<String, dynamic> json) => StockData(
        date: json["date"],
        stockInfo: json["stockInfo"] == null
            ? []
            : List<StockInfo>.from(
                json["stockInfo"].map((x) => StockInfo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "stockInfo": List<dynamic>.from(stockInfo.map((x) => x.toMap())),
      };

  factory StockData.create() => StockData(date: "", stockInfo: []);
}

class StockInfo {
  StockInfo({
    required this.closePrice,
    required this.change,
    required this.priceDiff,
    required this.status,
    required this.closePriceTrend,
    required this.code,
    required this.stockClass,
    required this.industry,
    required this.name,
  });

  num closePrice;
  num change;
  num priceDiff;
  int status;
  List<num> closePriceTrend;
  String code;
  String stockClass;
  String industry;
  String name;

  factory StockInfo.fromJson(String str) => StockInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockInfo.fromMap(Map<String, dynamic> json) => StockInfo(
        closePrice: json["closePrice"] ?? json["closePrice"].toDouble(),
        change: json["change"] ?? json["change"].toDouble(),
        priceDiff: json["priceDiff"] ?? json["priceDiff"].toDouble(),
        status: json["status"] ?? json["status"],
        closePriceTrend: json["closePriceTrend"] == null
            ? []
            : List<double>.from(
                json["closePriceTrend"].map((x) => x.toDouble())),
        code: json["code"] ?? json["code"],
        stockClass: json["class"],
        industry: json["industry"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "closePrice": closePrice,
        "change": change,
        "priceDiff": priceDiff,
        "status": status,
        "closePriceTrend": List<dynamic>.from(closePriceTrend.map((x) => x)),
        "code": code,
        "class": stockClass,
        "industry": industry,
        "name": name,
      };
}

class StockInfoDetails {
  StockInfoDetails({
    required this.closePrice,
    required this.change,
    required this.volume,
    required this.per,
    required this.pbr,
    required this.priceDiff,
    required this.paidInCapital,
    required this.reason,
    required this.status,
    required this.closePriceTrend,
    required this.openPrice,
    required this.highestPrice,
    required this.lowestPrice,
    required this.yesterdayClosePrice,
    required this.code,
    required this.stockClass,
    required this.industry,
    required this.name,
  });

  num closePrice;
  num change;
  num volume;
  num per;
  num pbr;
  num priceDiff;
  num paidInCapital;
  String reason;
  num status;
  List<num> closePriceTrend;
  num openPrice;
  num highestPrice;
  num lowestPrice;
  num yesterdayClosePrice;
  String code;
  String stockClass;
  String industry;
  String name;

  factory StockInfoDetails.fromJson(String str) =>
      StockInfoDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockInfoDetails.fromMap(Map<String, dynamic> json) =>
      StockInfoDetails(
        closePrice: json["closePrice"],
        change: json["change"],
        volume: json["volume"],
        per: json["per"],
        pbr: json["pbr"],
        priceDiff: json["priceDiff"],
        paidInCapital: json["paidInCapital"],
        reason: json["reason"],
        status: json["status"],
        closePriceTrend: json["closePriceTrend"] == null
            ? []
            : List<double>.from(
                json["closePriceTrend"].map((x) => x.toDouble())),
        openPrice: json["openPrice"],
        highestPrice: json["highestPrice"],
        lowestPrice: json["lowestPrice"],
        yesterdayClosePrice: json["yesterdayClosePrice"],
        code: json["code"],
        stockClass: json["class"],
        industry: json["industry"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "closePrice": closePrice,
        "change": change,
        "volume": volume,
        "per": per,
        "pbr": pbr,
        "priceDiff": priceDiff,
        "paidInCapital": paidInCapital,
        "reason": reason,
        "status": status,
        "closePriceTrend": List<dynamic>.from(closePriceTrend.map((x) => x)),
        "openPrice": openPrice,
        "highestPrice": highestPrice,
        "lowestPrice": lowestPrice,
        "yesterdayClosePrice": yesterdayClosePrice,
        "code": code,
        "class": stockClass,
        "industry": industry,
        "name": name,
      };

  factory StockInfoDetails.create() => StockInfoDetails(
        closePrice: 0,
        change: 0,
        volume: 0,
        per: 0,
        pbr: 0,
        priceDiff: 0,
        paidInCapital: 0,
        reason: "",
        status: 0,
        closePriceTrend: [],
        openPrice: 0,
        highestPrice: 0,
        lowestPrice: 0,
        yesterdayClosePrice: 0,
        code: "",
        stockClass: "",
        industry: "",
        name: "",
      );
}

class MyGroup {
  MyGroup({required this.codes, required this.group, required this.id});

  List<String> codes;
  String group;
  int id;

  factory MyGroup.fromJson(String str) => MyGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyGroup.fromMap(Map<String, dynamic> json) => MyGroup(
        codes: List<String>.from(json["codes"].map((x) => x)),
        group: json["group"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "codes": codes,
        "group": group,
        "id": id,
      };

  factory MyGroup.create() => MyGroup(codes: [], group: "", id: 0);
}

class StockOption {
  StockOption({
    required this.name,
    required this.code
  });

  String name;
  String code;

  factory StockOption.fromJson(String str) => StockOption.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockOption.fromMap(Map<String, dynamic> json) => StockOption(
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
      };

  factory StockOption.create() => StockOption(name: "", code: "");
}
