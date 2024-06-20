import 'package:flutter/material.dart';
import 'package:pokedex/GlassTextured.dart';
import 'package:pokedex/SuggestionTemplate.dart';
import 'package:pokedex/backend_request.dart';
import 'package:http/http.dart';
import 'package:pokedex/main.dart';

List<String> sugg_list= [];
List card_details = [];
List<Widget> cards = [];

Future get_suggested_list() async{
  await backend_request.get_rand(n: 5).then((onValue){
    sugg_list = onValue;
  });
}



Future get_suggested_list_b(List l_1) async {
  card_details = [];
  for (int i=0;i<l_1.length;i++){
    String name_ = "";
    String weight = "";
    String height = "";
    String front_url_ref = "";
    List type_arr = [];
    await backend_request.fetch_results(name: l_1[i]).then(
            (onValue) {
          type_arr = onValue["types"] != null ? onValue["types"].toList() : [];
          for (int i=0;i<type_arr.length;i++){
            type_arr[i] = type_arr[i]["type"]["name"];
          }
          name_ = sugg_list[i].toString().toUpperCase();
          weight = onValue["weight"].toString().toUpperCase();
          height = (int.parse(onValue["height"].toString())/10).toString().toUpperCase();
          front_url_ref = onValue["sprites"]["front_default"].toString();
        });
    String type_chain = type_arr.join(", ");
    card_details.add([name_,type_chain,weight,height,front_url_ref]);
  }

}

void get_suggestion_cards(List l_ref) {
  List<Suggestiontemplate> l_1 = [];
  for (int i = 0; i < l_ref.length; i++) {
  l_1.add(Suggestiontemplate(name: l_ref[i][0], type: l_ref[i][1], front_img_url: l_ref[i][4], weight: l_ref[i][2], height: l_ref[i][3]));
  }
  cards = l_1;
}

void main() async{
  await get_suggested_list();
  await get_suggested_list_b(sugg_list);
  get_suggestion_cards(card_details);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}




class HomePage extends StatefulWidget {
  static String search_text="";
  HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This widget is the root of your application.
  static String search_key = "";

  Future update_results() async{

    await backend_request.get_search_res(str_1: search_key).then((onValue) {
      sugg_list = onValue;
    });
    await get_suggested_list_b(sugg_list);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: ListView(children: [
            Container(
              padding: EdgeInsets.all(30),
                child: Image.asset("assets/poklogo.png")
            ),
        Container(child: Container(
          margin: EdgeInsets.all(10),
          height: 40,
          padding: EdgeInsets.all(2),
          child: Row(
            children: [
              Expanded(child: Container(
                width: 215,
                height: 40,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(left:10,bottom: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: Color.fromRGBO(38, 38, 38, 0.5),
                ),

                child: TextField(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    labelText: "Pokemon name",
                    labelStyle: TextStyle(
                      fontFamily: "Roboto",
                      color: Colors.grey.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                  onChanged: (newTxt){
                    search_key = newTxt;
                  },
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              ),),

              ElevatedButton(child: Text("SEARCH"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(38, 38, 38, 0.5),
                    foregroundColor: Colors.white,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.zero,topLeft: Radius.zero,bottomRight: Radius.circular(10))
                    ),
                  ),
                  onPressed: () async{
                    await update_results();
                    setState(() {
                      get_suggestion_cards(card_details);
                    });
                  })
            ],
          ),
        )
        ),
            Container(
                height: 500,
                child: ListView(
              children: cards,
                )
            )
          ],
          ),

        );
  }
}

