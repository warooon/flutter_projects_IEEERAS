import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe/models/recipe.dart';

class ApiReq{
  //	headers: {
  // 		'x-rapidapi-key': '744976b155mshf39683f6f476d70p10b697jsne18589534ce2',
  // 		'x-rapidapi-host': 'yummly2.p.rapidapi.com'
  // 	}


  static Future<List<Recipe>> get_recipe() async{
    var uri_temp = Uri.https('yummly2.p.rapidapi.com','/feeds/list',{"limit": "18", "start": "0", "tag": "list.recipe.popular"});
    final resp = await http.get(uri_temp,headers: {
     		'x-rapidapi-key': '744976b155mshf39683f6f476d70p10b697jsne18589534ce2',
     		'x-rapidapi-host': 'yummly2.p.rapidapi.com',
          "useQueryString": "true"
     	});

    Map return_data = jsonDecode(resp.body);
    List l_1 = [];

    for (var i in return_data["feed"]){
      print(i["ingredientLines"]);
      l_1.add([i["content"]["details"],i["content"]["ingredientLines"]]);
    }

    return Recipe.get_listed_details(l_1);
  }
}