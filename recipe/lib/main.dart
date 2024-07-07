import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/models/recipe.dart';
import 'package:recipe/models/recipe.api.dart';
import 'package:recipe/card.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';



class Controller_ extends GetxController{
  static List<Recipe> recipe_details = <Recipe>[].obs;

  static Future<void> getRecipes() async {
    Controller_.recipe_details = await ApiReq.get_recipe();
    print(Controller_.recipe_details);
  }
}


void main() async{
  await Controller_.getRecipes();
  runApp(const MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage()
    );
  }
}

class MainPage extends StatelessWidget {


  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.soup_kitchen,color: Colors.white,),
            Text("RECIPES LIST",style: TextStyle(fontFamily: "KanitB",fontSize: 20,color: Colors.white)),
          ],
        ),
        backgroundColor: Color.fromRGBO(33 ,33,33, 1),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(6, 2, 2,1),
                Color.fromRGBO(106, 0, 153,1)],
              stops: [0.3,0.924]
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            height: 300,
            width: 600,
              child: SizedBox(
                width: double.infinity,
                height: 500,
                  child: ScrollSnapList(
                    itemBuilder: ScrollListBuilder,
                    itemCount: Controller_.recipe_details.length,
                    itemSize: 300,
                    onItemFocus: (index){},
                    dynamicItemSize: true,
                  ),
              ),
          ),
        ),
      ),
    );
  }
  Widget ScrollListBuilder(BuildContext context,int index){
    Recipe focus_recipe = Controller_.recipe_details[index];
    return HomeCard(name: focus_recipe.recipe_name, time: focus_recipe.time, img_url: focus_recipe.ref_img, res: 300, rating: focus_recipe.recipe_ratings, ingredients: focus_recipe.ingredient_list,);
  }
}
