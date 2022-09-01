import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class BrokerBloc extends Bloc<BrokerEvent, BrokerState> {
  BrokerBloc(): super(BrokerState().init()) {
    on<InitEvent>((event, emit) => _init(event, emit));
    on<UpdateBrokersEvent>((event, emit) => _upBrokers(event, emit));
  }

  void _init(InitEvent event, Emitter<BrokerState> emit) {
    emit(state.clone());
  }

  void _upBrokers(UpdateBrokersEvent event, Emitter<BrokerState> emit) {
    state.brokers = event.brokers;
    emit(state.clone());
  }
}