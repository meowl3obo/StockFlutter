part of 'bloc.dart';

class AuthState {
  late String account;
  late String email;
  late String token;
  late int rank;
  
  AuthState init() {
    return AuthState()
        ..account = ''
        ..email = ''
        ..token = ''
        ..rank = 0;
  }

  AuthState clone() {
    return AuthState()
      ..account = account
      ..token = token
      ..email = email
      ..rank = rank;
  }
}
