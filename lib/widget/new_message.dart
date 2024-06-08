import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController message = new TextEditingController();

    void dispose() {
      message.dispose();
      super.dispose();
    }

    void submitmessage() async {
      final enteredmessage = message.text;

      if (enteredmessage.trim().isEmpty) {
        return;
      }

      final user = FirebaseAuth.instance.currentUser!;
      final userdata = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      FirebaseFirestore.instance.collection("chat").add({
        'text': enteredmessage,
        'createdAt': Timestamp.now(),
        'userid': user.uid,
        'username': userdata.data()!['username'],
        'userimage': userdata.data()!['imageurl']
      });

      FocusScope.of(context).unfocus();
      message.clear();
    }

    return Padding(
        padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: message,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(hintText: 'Send The Message.....'),
            )),
            IconButton.outlined(
                onPressed: () {
                  submitmessage();
                },
                icon: Icon(Icons.send)),
          ],
        ));
  }
}
