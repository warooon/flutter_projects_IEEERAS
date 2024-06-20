import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/GlassTextured.dart';
import 'package:pokedex/PokemonDetails.dart';

class Suggestiontemplate extends StatefulWidget {
  String name = "";
  String type = "";
  String front_img_url = "";
  String height = "";
  String weight = "";
  Suggestiontemplate({super.key ,required this.name,required this.type ,required this.front_img_url ,required this.weight ,required this.height});

  @override
  State<Suggestiontemplate> createState() => _SuggestiontemplateState();
}

class _SuggestiontemplateState extends State<Suggestiontemplate> {
  TextStyle content_style = TextStyle(
    color: Color.fromRGBO(28, 28, 28, 1),
    fontSize: 15,
    fontFamily:'Kanit',
  );

  @override
  Widget build(BuildContext context) {
    return Glasstextured(width_: double.infinity,
      height_: 100,
    container_child: InkWell(
      child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("${this.widget.name}",style: content_style),
                Text("${this.widget.type}",style: content_style),
                Text("${this.widget.height} m    ${this.widget.weight} lbs",style: content_style,)
              ],
            ),
            Container(child: Image.network(this.widget.front_img_url),
            alignment: Alignment.centerRight,)
          ],
          ),
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Pokemondetails(name: this.widget.name,
          height: this.widget.height,
          weight: this.widget.weight,
          type: this.widget.type,
        img_url: this.widget.front_img_url,)
          )
        );
      },
    ),
    );
  }
}
