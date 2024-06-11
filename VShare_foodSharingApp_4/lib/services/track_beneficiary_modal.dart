import 'package:flutter/material.dart';

class TrackBeneficiaryModal extends ChangeNotifier {
  List _foodAvailable = [];

  List get foodAvailable => _foodAvailable;

  void updateFoodAvailable(List foods) {
    _foodAvailable = foods;
    notifyListeners();
  }
}
