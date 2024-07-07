import 'dart:io';

class Recipe{
  String recipe_name = "";
  String ref_img = "";
  double recipe_ratings = 0.0;
  String time = "";
  List<String> ingredient_list = <String>[];

  Recipe({required this.recipe_name, required this.ref_img,required this.recipe_ratings, required this.time, required this.ingredient_list});

  factory Recipe.export_data(dynamic json_resp){
    List<String>ingredient_list_temp = [];
    for (var i in json_resp[1] as List){
      ingredient_list_temp.add(i["wholeLine"]);
    }
    return Recipe(recipe_name: json_resp[0]["name"] as String,
    ref_img: json_resp[0]['images'][0]['hostedLargeUrl'] as String,
    recipe_ratings: json_resp[0]["rating"] as double,
    time: json_resp[0]["totalTime"] as String,
    ingredient_list: ingredient_list_temp);
  }

  static List<Recipe> get_listed_details(List l_1){
    return l_1.map(
        (data) {
          return Recipe.export_data(data);
        }
    ).toList();
  }

  @override
  String toString(){
    return 'Recipe {recipe_name: $recipe_name,ref_img : $ref_img,recipe_ratings : $recipe_ratings,time : $time, ingredient_list : $ingredient_list}';
  }

}