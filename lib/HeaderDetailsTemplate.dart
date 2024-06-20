import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/GlassTextured.dart';
import 'package:pokedex/HeaderDetailsTemplate.dart';


class Headerdetailstemplate extends StatelessWidget {
  final audio_ref = AudioPlayer();
  bool playing = false;
  TextStyle header_style = TextStyle(
    color: Color.fromRGBO(28, 28, 28, 1),
    fontSize: 25,
    fontFamily:'Kanit',
  );
  TextStyle content_style = TextStyle(
    color: Color.fromRGBO(28, 28, 28, 1),
    fontSize: 15,
    fontFamily:'Kanit',
  );
  String name = "";
  String img_url = "";
  String height = "";
  String weight = "";
  String type = "";
  String hp = "";
  String atk = "";
  String def = "";
  String spl_atk = "";
  String spl_def = "";
  String spd = "";
  String music_url = "";
  Headerdetailstemplate({super.key,required String this.name,required String this.img_url,required String this.hp,required String this.atk,required String this.def,required String this.spl_atk, required String this.spl_def, required String this.spd ,required String this.type ,required String this.weight ,required String this.height ,required String this.music_url});


  @override
  Widget build(BuildContext context) {
    return Glasstextured(width_: double.infinity,
    height_: 450,
    container_child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: ElevatedButton(child: Icon(Icons.play_arrow), onPressed: () async{
                await audio_ref.play(UrlSource(music_url));
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                side: BorderSide(color: Colors.black),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,

              ),),
              margin: EdgeInsets.only(left:35),
            ),
            Flexible(child: Text("${name}",style: header_style,textAlign: TextAlign.center,) ,),
          ],
        ),
        Container(child: Image.network("${img_url}"),
        width: 100,
        height: 100,
        margin: EdgeInsets.all(10),),
        Container(child: Column(
          children: [
            Container(child: Text("TYPE : ${type.toUpperCase()}",style: content_style,textAlign: TextAlign.center,),width: double.infinity,padding: EdgeInsets.all(10)),
            Container(child: Text("WEIGHT : ${weight} LBS          HEIGHT : ${height} m",style: content_style,textAlign: TextAlign.center,),width: double.infinity,padding: EdgeInsets.all(10)),
          ],
        ),),
        Container(child: Text("STATS",style: content_style,textAlign: TextAlign.left,),width: double.infinity,padding: EdgeInsets.all(10)),
        Text("HP  : ${hp}              SPEED   : ${spd}",style: content_style,textAlign: TextAlign.center,),
        Text("ATK : ${atk}             SPL ATK : ${spl_atk}",style: content_style,textAlign: TextAlign.center,),
        Text("DEF : ${def}             SPL DEF : ${spl_def}",style: content_style,textAlign: TextAlign.center,),
      ],
    ),);
  }
}
