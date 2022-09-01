part of 'bloc.dart';

class TestState {
  late int count;
  
  TestState init() {
    return TestState()
     ..count = 0;
  }

  TestState clone() {
    return TestState()
     ..count = count;
  }
}