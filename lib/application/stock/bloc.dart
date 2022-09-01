import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc(): super(StockState().init()) {
    on<InitEvent>((event, emit) => _init(event, emit));
    on<UpdateLastTradingEvent>((event, emit) => _upTradingDay(event, emit));
    on<UpdateAllStockEvent>((event, emit) => _upAllStock(event, emit));
    on<UpdateIndustryEvent>((event, emit) => _upIndustrys(event, emit));
  }

  void _init(InitEvent event, Emitter<StockState> emit) {
    emit(state.clone());
  }

  void _upTradingDay(UpdateLastTradingEvent event, Emitter<StockState> emit) {
    state.lastTradingDay = event.date;
    emit(state.clone());
  }

  void _upAllStock(UpdateAllStockEvent event, Emitter<StockState> emit) {
    state.allStock = event.allStock;
    emit(state.clone());
  }

  void _upIndustrys(UpdateIndustryEvent event, Emitter<StockState> emit) {
    state.industrys = event.industrys;
    emit(state.clone());
  }
}
