import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_list/AddTask.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static String read_val="";
  const MyApp({super.key});
  static Future<String> get working_dir async{
    print("Enters");
    Directory? dir_ = await getTemporaryDirectory();
    print(dir_.path+"this is path");
    return dir_.path;
  }
  static Future<File> get file_inst async{
    dynamic path = "/storage/emulated/0/Download/";
    return File("$path/list.txt");
  }
  static Future<File> write({required String text}) async{
    File file_ = await file_inst;
    return file_.writeAsString(text);
  }
  static Future<File> append({required String text}) async{
    File file_ = await file_inst;
    return file_.writeAsString(text,mode: FileMode.append);
  }
  static Future<String> read() async{
    try{
      File file_ = await file_inst;
      String content  = await file_.readAsString();
      return content;
    }catch(e){
      return "";
    }
  }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  List<Center> l_1 = [];
  @override
  Widget build(BuildContext context) {
    String content_val = "";
    MyApp.read().then((String content_val){
      setState(() {
        l_1 = [];
        print("Who knows: :"+content_val);
        List<String> content = [];
        if (content_val.split("\n")==[] && content_val!=""){
          print("Enters-1");
          content.add(content_val);
        }else{
          content = content_val.split("\n");
        }
        print("works");
        print("content here : "+content.toString());
        if (content!=[]) {
          for (int i = 0; i < content.length-1; i++) {
            l_1.add(Center(
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(38, 38, 38, 1),Color.fromRGBO(23, 23, 23, 1),Color.fromRGBO(0, 0, 0, 1)],
                    stops: [0.0,0.5,1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [Text("${content[i].split(",")[0].toUpperCase()}",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      )),
                    Text("${content[i].split(",")[1]}",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          color: Colors.white,
                        )),
                    Text("${content[i].split(",")[2]}",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ));
          }
        }else{
          l_1= [
            Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Text("No content to display",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontFamily: 'Roboto',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            )
          ];
        }
      });
    });
    print("outside lol "+l_1.length.toString());
    return Scaffold(
    appBar: AppBar(
      flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromRGBO(255, 230, 109, 1),Color.fromRGBO(87, 232, 107, 1)],
        stops: [0.112,100.2],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
      ),
    ),
    ),
    backgroundColor: Color.fromRGBO(145, 39, 227, 1),
    title: Text("ToDoList",style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.bold)),
    centerTitle: true,
    ),
    backgroundColor: Color.fromRGBO(26, 26, 26, 1),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(255, 230, 109, 1),Color.fromRGBO(87, 232, 107, 1)],
          stops: [0.112,100.2],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView(
      children: l_1,
      ),
    ),
    floatingActionButton: FloatingActionButton(
    elevation: 20,
    backgroundColor: Color.fromRGBO(69, 250, 52, 1),
    child: Icon(Icons.add),
    hoverColor: Color.fromRGBO(161, 158, 163, 1),
    onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
    },
    ),
    );
  }
}
