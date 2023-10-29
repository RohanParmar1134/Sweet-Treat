import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier {
  int counter = 0;
  int get getcounter {
    return counter;
  }

  void increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    counter--;
    notifyListeners();
  }
}
