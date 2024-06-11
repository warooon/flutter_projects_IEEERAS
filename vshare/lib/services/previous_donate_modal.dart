import 'package:flutter/material.dart';

class PreviousDonateModal extends ChangeNotifier {
  List _previousDonations = [];

  List get previousDonations => _previousDonations;

  void updatePreviousDonations(List donations) {
    _previousDonations = donations;
    notifyListeners();
  }
}
