import 'package:flutter/material.dart';

class GoalAmount extends ChangeNotifier {
  int _amount;

  int get amount => _amount;

  set amount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  GoalAmount({required int amount}) : _amount = amount;
}
