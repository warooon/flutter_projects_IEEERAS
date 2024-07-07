import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/DetailedPage.dart';

class HomeCard extends StatelessWidget {
  String name;
  String time;
  String img_url;
  double res;
  double rating;
  List<String> ingredients;
  HomeCard({super.key,required this.name,required this.time ,required this.img_url, required this.res, required this.rating, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: res,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(201, 44, 196, 1),
            width: 3.0
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(102, 2, 120,1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset (0,0),
            )
          ],
          image: DecorationImage(image: NetworkImage(img_url),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Align(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(name.toUpperCase(),style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Kanit",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black, blurRadius: 3.0,
                    ),
                    Shadow(
                      color: Colors.black87, blurRadius: 3.0
                    )
                  ]
                ),
                overflow: TextOverflow.ellipsis),
              ),
              alignment: Alignment.bottomLeft,
            ),
            Align(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  width: time.length.toDouble()*10,
                  padding: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(33,33,33, 0.5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.timer,color: Colors.grey, size: 18,),
                      Expanded(child: Text(time.toUpperCase(),style: TextStyle(fontFamily: "KanitB",fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)))
                    ],
                  ),
                )
              ),
              alignment: Alignment.topLeft,
            ),
            Align(
              child: Padding(

                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(33,33,33, 0.5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.star,color: Colors.yellow,size: 18,),
                        Text(rating.toString(),style: TextStyle(fontFamily: "KanitB",fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                      ],
                    ),
                  )
              ),
              alignment: Alignment.topRight,
            ),
          ],
        ),

      ),
      onTap: ()=>Get.to(Detailedpage(name: name,img_url: img_url,rating: rating, time: time,ingredients: ingredients,)),
    );
  }
}
