import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class backend_request {

  static Future fetch_url({required String url}) async{
    final response = await http.get(Uri.parse(url));
    if (response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception("Failed to load data");
    }

  }

  static Future fetch_results({required String name}) async{
    final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/${name}"));
    if (response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception("Failed to load data");
    }
  }

  static Future<String> get_abilities(String url) async{
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode==200){
      final body_ = json.decode(resp.body);
      List l_1 = body_["effect_entries"].toList();
      for (int i=0;i<l_1.length;i++){
        if (l_1[i]["language"]["name"].toString()=="en"){
          return l_1[i]["effect"].toString();
        }
      }
    }else{
      throw Exception("Data not loaded");
    }
    return "";
  }

  static Future<List<String>> get_search_res({required String str_1}) async{
    List<String> l_1 = [];
    final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/?limit=2000"));
    if (response.statusCode==200){
      List value = json.decode(response.body)["results"];
      for (int i=0;i<json.decode(response.body)["count"];i++){
        if (value[i]["name"].toString().startsWith("$str_1")){
          l_1.add(value[i]["name"].toString());
        }
      }
    }
    return l_1;
  }

  static Future<String> get_desc(String url_) async{
    final resp = await http.get(Uri.parse(url_));
    if (resp.statusCode==200){
      List temp = (json.decode(resp.body)["flavor_text_entries"]).toList();
      for (int i=0;i<temp.length;i++){
        if (temp[i]["language"]["name"].toString()=="en"){
          return temp[i]["flavor_text"].toString();
        }
      }

    }
    return "";

  }

  static Future<List<String>> get_rand({required int n}) async{
    List<String> l_1 = [];
    for (int i=0;i<n;i++){
      var offset_seed = new Random();
      var offset = offset_seed.nextInt(1000);
      final resp = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/?offset=${offset}&limit=1"));
      if (resp.statusCode==200){
        l_1.add(json.decode(resp.body)["results"][0]["name"]);
      }else{
        throw Exception("Connection not properly established");
      }
    }
    return l_1;
  }


}