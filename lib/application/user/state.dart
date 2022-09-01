part of 'bloc.dart';

class UserState {
  late List<MyGroup> group;
  late Map<String, List<BrokerData>> myBrokers;
  
  UserState init() {
    return UserState()
        ..group = []
        ..myBrokers = {};
  }

  UserState clone() {
    return UserState()
      ..group = group
      ..myBrokers = myBrokers;
  }
}
