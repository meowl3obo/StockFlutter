import 'package:bloc/bloc.dart';
import 'package:flutter_application/model/broker.dart';
import 'package:flutter_application/model/stock.dart';

part 'event.dart';
part 'state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(): super(UserState().init()) {
    on<InitEvent>((event, emit) => _init(event, emit));
    on<UpdateGroupEvent>((event, emit) => _upGroup(event, emit));
    on<UpdateMyBrokersEvent>((event, emit) => _upMyBroker(event, emit));
  }

  void _init(InitEvent event, Emitter<UserState> emit) {
    emit(state.clone());
  }

  void _upGroup(UpdateGroupEvent event, Emitter<UserState> emit) {
    state.group = event.group;
    emit(state.clone());
  }

  void _upMyBroker(UpdateMyBrokersEvent event, Emitter<UserState> emit) {
    state.myBrokers = event.myBrokers;
    emit(state.clone());
  }
}