part of 'bloc.dart';

class StockState {
  late String lastTradingDay;
  late Map<String, String> allStock;
  late List<String> industrys;
  
  StockState init() {
    return StockState()
        ..lastTradingDay = ''
        ..allStock = {}
        ..industrys = [];
  }

  StockState clone() {
    return StockState()
      ..lastTradingDay = lastTradingDay
      ..allStock = allStock
      ..industrys = industrys;
  }
}
