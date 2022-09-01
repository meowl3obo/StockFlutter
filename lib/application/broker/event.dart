part of 'bloc.dart';

abstract class BrokerEvent {}

class InitEvent extends BrokerEvent {}

class UpdateBrokersEvent extends BrokerEvent {
  Map<String, List<String>> brokers;
  UpdateBrokersEvent({required this.brokers});
}