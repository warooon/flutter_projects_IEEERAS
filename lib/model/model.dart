import 'package:flutter/material.dart';

class Product {
  String productname;
  String productdescription;
  double productprice;
  String productimage;
  String completedescription;

  Product(
      {required this.productname,
      required this.productdescription,
      required this.productprice,
      required this.productimage,
      required this.completedescription});
}
