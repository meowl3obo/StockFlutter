import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc(): super(TestState().init()) {
    on<InitEvent>((event, emit) => _init(event, emit));
    on<AddEvent>((event, emit) => _add(event, emit));
    on<MinusEvent>((event, emit) => _minus(event, emit));
  }

  void _init(InitEvent event, Emitter<TestState> emit) {
    emit(state.clone());
  }

  void _add(AddEvent event, Emitter<TestState> emit) {
    state.count++;
    emit(state.clone());
  }

  void _minus(MinusEvent event, Emitter<TestState> emit) {
    state.count--;
    emit(state.clone());
  }
}
