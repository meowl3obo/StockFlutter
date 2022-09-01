part of 'bloc.dart';

abstract class UserEvent {}

class InitEvent extends UserEvent {}

class UpdateGroupEvent extends UserEvent {
  List<MyGroup> group;
  UpdateGroupEvent({required this.group});
}

class UpdateMyBrokersEvent extends UserEvent {
  Map<String, List<BrokerData>> myBrokers;
  UpdateMyBrokersEvent({required this.myBrokers});
}