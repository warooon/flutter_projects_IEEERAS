import 'package:chat_app/widget/message_bubble.dart';
import 'package:chat_app/widget/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key});

  @override
  Widget build(BuildContext context) {
    final authenticateduser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Data Available"));
        }

        if (snapshot.hasError) {
          return Center(child: Text("Something Went wrong"));
        }

        final messages = snapshot.data!.docs;
        return ListView.builder(
          padding: EdgeInsets.only(left: 13, right: 13, bottom: 30),
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final chatmessage = messages[index].data();
            final nextmessage =
                index + 1 < messages.length ? messages[index + 1] : null;
            final currentmessageuserid = chatmessage["userid"];
            final nextmessageuserid =
                nextmessage != null ? nextmessage["userid"] : null;

            final sameuserid = currentmessageuserid == nextmessage;

            if (sameuserid) {
              MessageBubble.next(
                  message: chatmessage['text'],
                  isMe: authenticateduser.uid == currentmessageuserid);
            } else {
              return MessageBubble.first(
                  userImage: chatmessage['userimage'],
                  username: chatmessage['username'],
                  message: chatmessage['text'],
                  isMe: authenticateduser.uid == currentmessageuserid);
            }
          },
        );
      },
    );
  }
}
