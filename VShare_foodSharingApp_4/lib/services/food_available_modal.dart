import 'package:flutter/material.dart';

class FoodAvailableModal extends ChangeNotifier {
  List _foodAvailable = [];

  List get foodAvailable => _foodAvailable;

  void updateFoodAvailable(List foods) {
    _foodAvailable = foods;
    notifyListeners();
  }
}
