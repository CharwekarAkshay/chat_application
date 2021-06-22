import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (ctx, futureSnapshot) =>
            futureSnapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Setting up Connections"),
                      ],
                    ),
                  )
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats/6WO29I5Box8Bo3f5Q0j3/messages')
                        .snapshots(),
                    builder: (ctx, streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final qSnap = streamSnapshot.data as QuerySnapshot;
                      final documents = qSnap.docs;
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (ctx, index) => Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(documents[index]['text']),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/6WO29I5Box8Bo3f5Q0j3/messages')
              .add({
                'text': 'This was added by clicking button'
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
