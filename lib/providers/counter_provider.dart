import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  // initail value
  int _counter = 0; // private variable

  int get count => _counter; // getter return _counter

  counterUp() {
    _counter++;
    notifyListeners();  // notify to component that use provider
  }

  counterDown() {
    _counter--;
    notifyListeners();  // notify to component that use provider
  }

}
