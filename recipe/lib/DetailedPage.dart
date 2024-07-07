import 'dart:ui';

import 'package:flutter/material.dart';

class Detailedpage extends StatelessWidget {
  String name = "";
  String time = "";
  String img_url = "";
  double rating = 0.0;
  List<String> ingredients = <String>[];
  Detailedpage({super.key,required this.name,required this.time,required this.img_url,required this.rating, required this.ingredients});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(name:name,time:time,img_url:img_url,rating: rating,ingredients: ingredients,),
    );
  }
}


class MainPage extends StatelessWidget {
  String name = "";
  String time = "";
  String img_url = "";
  double rating = 0.0;
  List<String> ingredients = <String>[];
  MainPage({super.key,required this.name,required this.time,required this.img_url,required this.rating, required this.ingredients});
  List<Widget> ingredient_list_widget(){
    List<Widget> l_1 = <Widget>[];
    for (var i in ingredients){
      if (i.length>0 && i.isNotEmpty){
        l_1.add(
            Row(
              children: [
                Container(margin: EdgeInsets.only(left: 20, right: 30 ,top: 20,bottom: 20),child: Icon(Icons.check_circle_sharp,color: Colors.grey)),
                Flexible(
                  child: Text("${i}",style: TextStyle(fontFamily: "Kanit",fontSize: 16,color: Colors.white ,shadows: <Shadow>[
                    Shadow(
                      color: Colors.black,
                      blurRadius: 7,
                      offset: Offset(0,0),
                    )
                  ],
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            )
        );
      }
    }
    return l_1;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dinner_dining,color: Colors.white,),
            Text("RECIPE DETAILS",style: TextStyle(fontFamily: "KanitB",fontSize: 20,color: Colors.white)),
          ],
        ),
        backgroundColor: Color.fromRGBO(33 ,33,33, 1),
        centerTitle: true,
      ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(6, 2, 2,1),
                    Color.fromRGBO(106, 0, 153,1)],
                  stops: [0.3,0.924]
              ),
            image: DecorationImage(image: NetworkImage(img_url),alignment: Alignment.topCenter)
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(width: double.infinity, height: 250,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
              ),
              color: Color.fromRGBO(255,255,255, 0.05),),
              Container(width: double.infinity,
                margin: EdgeInsets.only(top: 10,left: 10,right: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(33,33,33,0.7),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
                child: Column(
                  children: [
                    Container(margin: EdgeInsets.only(left: 30,top:30,right: 10,bottom: 30),
                    child: Text("DISH NAME : ${name.toUpperCase()}",style: TextStyle(fontFamily: "Kanit",fontSize: 16,color: Colors.white, shadows: <Shadow>[
                      Shadow(
                        color: Colors.black,
                        blurRadius: 7,
                        offset: Offset(0,0),
                      )
                    ],
                      fontWeight: FontWeight.bold,
                    ),),),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("TIME : ${time.toUpperCase()}",style: TextStyle(fontFamily: "Kanit",fontSize: 16,color: Colors.white, shadows: <Shadow>[
                            Shadow(
                              color: Colors.black,
                              blurRadius: 7,
                              offset: Offset(0,0),
                            )
                          ],
                            fontWeight: FontWeight.bold,
                          ),),
                          Container(
                            padding: EdgeInsets.all(30),
                            child: Text("RATING : ${rating.toString()}",style: TextStyle(fontFamily: "Kanit",fontSize: 16,color: Colors.white, shadows: <Shadow>[
                              Shadow(
                                color: Colors.black,
                                blurRadius: 7,
                                offset: Offset(0,0),
                              )
                            ],
                              fontWeight: FontWeight.bold,
                            ),),
                          ),

                        ],
                        
                      ),
                    ),
                    Text("INGREDIENTS",style: TextStyle(fontFamily: "Kanit",fontSize: 16,color: Colors.white, shadows: <Shadow>[
                      Shadow(
                        color: Colors.black,
                        blurRadius: 7,
                        offset: Offset(0,0),
                      )
                    ],
                      fontWeight: FontWeight.bold,
                    ),),
                    Container(
                      child: Column(
                        children: ingredient_list_widget(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
