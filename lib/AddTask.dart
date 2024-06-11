import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/main.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home: AddPage(),
    );
  }
}


class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  dynamic task_name = "";
  dynamic task_desc = "";
  int hr = 0;
  int min = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(36, 36, 36, 1),
                Color.fromRGBO(54, 54, 54, 1),
                Color.fromRGBO(62,62,62, 1),
              ],
              stops: [0.5,0.7,1.0],
            )
          ),
        ),
        title: Text("ADD TASK",style: TextStyle(
          fontFamily:'Roboto',
          color: Colors.lightBlue,

          fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(26, 26, 26, 1),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(71, 71, 71, 1),
              Color.fromRGBO(42, 40, 40, 1),
              Color.fromRGBO(32, 32, 32, 1),
            ],
            stops: [0.4,0.8,0.9]
          )
        ),
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlueAccent,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              margin: EdgeInsets.only(left: 8,right: 10,top: 30, bottom: 15),
              padding: EdgeInsets.only(left:10),
              width: double.infinity,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(","),
                ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Task name",
                    labelStyle: TextStyle(
                      fontFamily: "Roboto",
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                onChanged: (newTxt){
                    task_name = newTxt;
                },
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.lightBlueAccent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              margin: EdgeInsets.only(left: 8,right: 10,top: 30, bottom: 15),
              padding: EdgeInsets.only(left:10),
              width: double.infinity,
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                  FilteringTextInputFormatter.deny(","),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Task description (less than 50 characters)",
                  labelStyle: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.lightBlueAccent,
                  ),
                ),
                onChanged: (newTxt){
                  task_desc = newTxt;
                },
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              height: 100,
              child: ListView(
               scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 60,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "HR",
                        labelStyle: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.blueAccent,
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.blueAccent,
                        fontSize: 10,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      onChanged: (newTxt){
                        hr = int.parse(newTxt);
                      },
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left:30),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: TextField(

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "MIN",
                        labelStyle: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.blueAccent,
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.blueAccent,
                        fontSize: 10,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),

                      ],
                      onChanged: (newTxt){
                        min = int.parse(newTxt);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width:double.infinity,
              height: 35,
              margin: EdgeInsets.all(20),
              alignment: Alignment.bottomCenter,
              child: ListView(
                scrollDirection: Axis.horizontal,

                children: <Widget>[
                  ElevatedButton(
                    child: Text("CONFIRM"),
                    style: ElevatedButton.styleFrom(foregroundColor: Colors.blueAccent,
                      backgroundColor: Color.fromRGBO(54, 54, 54, 1),
            ),
                    onPressed: () {
                      setState(() {
                        MyApp.append(text: "${task_name},${task_desc},${hr}:${min}\n");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                      });
                    },
                  ),
                  Container(
                    width: 125,
                    height: 35,
                    margin: EdgeInsets.only(left:20),
                    child: ElevatedButton(
                      child: Text("CANCEL"),
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.blueAccent,
                        backgroundColor: Color.fromRGBO(54, 54, 54, 1),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                      },
                    ),
                  ),

                ],
              ),
            )
          ],

        ),
      )

    );
  }
}
