import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class FoodDonateModal extends ChangeNotifier {
  String _foodname = "";
  String _foodquantity = "";
  LatLng? _location;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  List<dynamic> _images = [];

  String get foodname => _foodname;
  String get foodquantity => _foodquantity;
  LatLng? get location => _location;
  TimeOfDay get time => _time;
  List<dynamic> get images => _images;

  void setFoodName(String foodname) {
    _foodname = foodname;
    notifyListeners();
  }

  void setFoodQuantity(String foodquantity) {
    _foodquantity = foodquantity;
    notifyListeners();
  }

  void setLocation(LatLng? location) {
    _location = location;
    notifyListeners();
  }

  void setTime(TimeOfDay time) {
    _time = time;
    notifyListeners();
  }

  void setImages(List<dynamic> images) {
    _images = images;
    notifyListeners();
  }
}
