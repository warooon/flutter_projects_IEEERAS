import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/DescriptionTemplate.dart';
import 'package:pokedex/HeaderDetailsTemplate.dart';
import 'package:pokedex/MovesTemplate.dart';
import 'package:pokedex/backend_request.dart';
import 'package:pokedex/main.dart';


class Pokemondetails extends StatefulWidget {
  static String name_ = "";
  static String height_ = "";
  static String weight_ = "";
  static String type_ = "";
  static String img_url_ = "";
  static Map<String,String> stats = {"hp":"","attack":"","defense":"","special-attack":"","special-defense":"","speed":""};
  static String ability = "";
  static String music_url = "";
  static int moves_list_count = 0;
  static String left_col_val = "";
  static String right_col_val = "";
  static String desc = "";
  static String abilities_desc = "";
  Pokemondetails({super.key, required String name, required String height ,required String weight ,required String type, required String img_url}){
    name_ = name;
    height_ = height;
    weight_ = weight;
    type_ = type;
    img_url_ = img_url;
  }

  @override
  State<Pokemondetails> createState() => _PokemondetailsState();
}

class _PokemondetailsState extends State<Pokemondetails> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailsPage(),
    );
  }
}


class DetailsPage extends StatefulWidget {
  static TextStyle content_style = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontFamily:'Robotc',
  );
  DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {


  @override
  void initState(){
    // TODO: implement initState
    List l_1 = [];
    super.initState();
    backend_request.fetch_results(name: Pokemondetails.name_.toString().toLowerCase()).then((onValue) {
      l_1 = onValue["stats"].toList();
      for (int i=0;i<l_1.length;i++){
        setState(() {
          Pokemondetails.stats[l_1[i]["stat"]["name"]] = l_1[i]["base_stat"].toString();
        });
      }
      List l_2 = onValue["abilities"].toList();
      List l_2_temp = [];
      List ability_overview_temp = [];
      for (int i=0;i<l_2.length;i++){
        l_2_temp.add(l_2[i]["ability"]["name"]);
        backend_request.get_abilities(l_2[i]["ability"]["url"]).then((onValue) {
          setState(() {
            Pokemondetails.abilities_desc+=("\n\t${l_2[i]["ability"]["name"]} - ${onValue}");
          });
        });
      }
      setState(() {
        Pokemondetails.abilities_desc = ability_overview_temp.join("\n");
      });

      Pokemondetails.ability = l_2_temp.join(",");
      Pokemondetails.music_url = onValue["cries"]["legacy"].toString();
      List l_3 = onValue["moves"].toList();
      List l_temp = [];
      Pokemondetails.moves_list_count = (l_3.length/2).ceil();
      for(int i=0;i<l_3.length;i++){
        l_temp.add(l_3[i]["move"]["name"]);
      }
      Pokemondetails.left_col_val = l_temp.sublist(0,Pokemondetails.moves_list_count).join("\n");
      Pokemondetails.right_col_val = l_temp.sublist(Pokemondetails.moves_list_count,l_temp.length).join("\n");
      backend_request.get_desc(onValue["species"]["url"].toString()).then((onValue) {
        String temp = onValue;
        setState(() {
          Pokemondetails.desc = temp;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(95, 15, 64,1),
            Color.fromRGBO(49, 14, 104 ,1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0,1.0],
        ),
      ),
      child: ListView(
        children: [
          Headerdetailstemplate(name: Pokemondetails.name_, img_url: Pokemondetails.img_url_, hp: Pokemondetails.stats["hp"].toString(), atk: Pokemondetails.stats["attack"].toString() ,def: Pokemondetails.stats["defense"].toString(), spl_atk: Pokemondetails.stats["special-attack"].toString(), spl_def: Pokemondetails.stats["special-defense"].toString(), spd: Pokemondetails.stats["speed"].toString() ,weight: Pokemondetails.weight_, height: Pokemondetails.height_, type: Pokemondetails.type_, music_url: Pokemondetails.music_url,),
          Container(child: Text("DESCRIPTION",style: DetailsPage.content_style,),alignment: Alignment.center,),
          Descriptiontemplate(desc: Pokemondetails.desc, abilities: Pokemondetails.abilities_desc),
          Container(child: Text("MOVES",style: DetailsPage.content_style,),alignment: Alignment.center,),
          Movestemplate(list_count: Pokemondetails.moves_list_count, left_col: Pokemondetails.left_col_val, right_col: Pokemondetails.right_col_val),
        ],
      ),
    )
    );
  }
}
