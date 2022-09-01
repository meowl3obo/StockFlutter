part of 'bloc.dart';

abstract class StockEvent {}

class InitEvent extends StockEvent {}

class UpdateLastTradingEvent extends StockEvent {
  String date;
  UpdateLastTradingEvent({required this.date});
}

class UpdateAllStockEvent extends StockEvent {
  Map<String, String> allStock;
  UpdateAllStockEvent({required this.allStock});
}

class UpdateIndustryEvent extends StockEvent {
  List<String> industrys;
  UpdateIndustryEvent({required this.industrys});
}