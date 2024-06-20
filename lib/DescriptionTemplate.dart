import 'package:flutter/material.dart';
import 'dart:io';

import 'package:pokedex/GlassTextured.dart';

class Descriptiontemplate extends StatelessWidget {
  String desc = "";
  String abilities = "";
  Descriptiontemplate({super.key,required String this.desc,required String this.abilities});
  TextStyle content_style = TextStyle(
    color: Color.fromRGBO(28, 28, 28, 1),
    fontSize: 15,
    fontFamily:'Kanit',
  );
  @override
  Widget build(BuildContext context) {
    return Glasstextured(container_child: ListView(
      children: [
        Container(child: Text("DESCRIPTION : \n\t ${desc.split("\n").join(" ")}".toUpperCase(),style: content_style,textAlign: TextAlign.left,),margin: EdgeInsets.only(bottom: 10),alignment: Alignment.topLeft,width: double.infinity,),
        Container(child: Text("ABILITIES : \n\t ${abilities}".toUpperCase(),style: content_style,textAlign: TextAlign.left,),margin: EdgeInsets.only(top: 10),),
      ],
    ), height_: 400, width_: double.infinity);
  }
}
