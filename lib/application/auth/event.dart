part of 'bloc.dart';

abstract class AuthEvent {}

class InitEvent extends AuthEvent {}

class UpdateAccountEvent extends AuthEvent {
  String account;
  UpdateAccountEvent({required this.account});
}

class UpdateTokenEvent extends AuthEvent {
  String token;
  UpdateTokenEvent({required this.token});
}

class UpdateEmailEvent extends AuthEvent {
  String email;
  UpdateEmailEvent({required this.email});
}

class UpdateRankEvent extends AuthEvent {
  int rank;
  UpdateRankEvent({required this.rank});
}

class LogoutEvent extends AuthEvent {}