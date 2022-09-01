import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(): super(AuthState().init()) {
    on<InitEvent>((event, emit) => _init(event, emit));
    on<UpdateAccountEvent>((event, emit) => _upAccount(event, emit));
    on<UpdateTokenEvent>((event, emit) => _upToken(event, emit));
    on<UpdateEmailEvent>((event, emit) => _upEmail(event, emit));
    on<UpdateRankEvent>((event, emit) => _upRank(event, emit));
    on<LogoutEvent>((event, emit) => _logout(event, emit));
  }

  void _init(InitEvent event, Emitter<AuthState> emit) {
    emit(state.clone());
  }

  void _upAccount(UpdateAccountEvent event, Emitter<AuthState> emit) {
    state.account = event.account;
    emit(state.clone());
  }

  void _upToken(UpdateTokenEvent event, Emitter<AuthState> emit) {
    state.token = event.token;
    emit(state.clone());
  }

  void _upEmail(UpdateEmailEvent event, Emitter<AuthState> emit) {
    state.email = event.email;
    emit(state.clone());
  }

  void _upRank(UpdateRankEvent event, Emitter<AuthState> emit) {
    state.rank = event.rank;
    emit(state.clone());
  }

  void _logout(LogoutEvent event, Emitter<AuthState> emit) {
    state.account = "";
    state.token = "";
    state.email = "";
    state.rank = 0;
    emit(state.clone());
  }
}