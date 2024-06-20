
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:pokedex/GlassTextured.dart';

class Movestemplate extends StatelessWidget {
  int list_count = 0;
  String left_col = "";
  String right_col = "";
  TextStyle content_style = TextStyle(
    color: Color.fromRGBO(28, 28, 28, 1),
    fontSize: 15,
    fontFamily:'Robotc',
  );
  Movestemplate({super.key,required int this.list_count,required String this.left_col,required String this.right_col});

  @override
  Widget build(BuildContext context) {
    double height_ = left_col.length*2.5;
    return Glasstextured(container_child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left_col.toUpperCase(),style: content_style,),
        Text(right_col.toUpperCase(),style: content_style,)
      ],
    ), height_: height_, width_: double.infinity);
  }
}
