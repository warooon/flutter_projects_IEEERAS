import 'dart:io';

import 'package:chat_app/widget/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var isLogin = true;
  final formKey = GlobalKey<FormState>();
  late String enteredEmail;
  late String enteredPassword;
  var enteredusername;
  File? selectedimage;

  void _onSubmit() async {
    final valid = formKey.currentState!.validate();

    if (!valid) {
      return;
    }

    formKey.currentState!.save();
    if (isLogin) {
      try {
        final userCredential = await firebase.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        print(userCredential);
        print('Success');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString())),
        );
      }
    } else {
      try {
        final userCredential = await firebase.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );

        selectedimage = imagepicked;
        final storageref = await FirebaseStorage.instance
            .ref()
            .child("user_image")
            .child("${userCredential.user!.uid}.jpeg");
        storageref.putFile(selectedimage!);

        await FirebaseFirestore.instance
            .collection("users")
            .doc("${userCredential.user!.uid}")
            .set({
          "username": enteredusername,
          "email": enteredEmail,
          "imageurl": selectedimage!.path
        });
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {}
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: 200,
                  child: Image.asset("assets/images/chat.png"),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isLogin) UserImagePicker(),
                          TextFormField(
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(labelText: 'Email'),
                            onSaved: (value) {
                              enteredEmail = value!;
                            },
                            validator: (value) {
                              if (!value!.contains('@') ||
                                  value.trim().isEmpty) {
                                return 'Valid email required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          if (!isLogin)
                            TextFormField(
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              decoration:
                                  InputDecoration(labelText: 'Username'),
                              onSaved: (value) {
                                enteredusername = value!;
                              },
                              validator: (value) {
                                if (value!.trim().length < 4 ||
                                    value.isEmpty ||
                                    value == null) {
                                  return 'Valid email required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          TextFormField(
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            onSaved: (value) {
                              enteredPassword = value!;
                            },
                            decoration: InputDecoration(labelText: 'Password'),
                            validator: (value) {
                              if (value!.trim().length < 6) {
                                return 'Password should be at least 6 characters long';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _onSubmit,
                            child: Text(isLogin ? 'Login' : 'SignUp'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin
                                  ? 'Create An Account'
                                  : 'I have already have an account',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
