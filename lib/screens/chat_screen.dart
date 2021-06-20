import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: const EdgeInsets.all(8),
          child: Text("This works"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Firebase.initializeApp();
          FirebaseFirestore.instance
              .collection('chats/6WO29I5Box8Bo3f5Q0j3/messages')
              .snapshots()
              .listen(
            (data) {
              // print(data.docs[0]['text']);
              data.docs.forEach((document) { 
                print(document['text']);
              });
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
