part of 'bloc.dart';

class BrokerState {
  late Map<String, List<String>> brokers;
  
  BrokerState init() {
    return BrokerState()
        ..brokers = {};
  }

  BrokerState clone() {
    return BrokerState()
      ..brokers = brokers;
  }
}
