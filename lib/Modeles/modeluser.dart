import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String id;

  User({
    this.id,
  });
}

List<User> totalcount = [];

 totalUsers() async {
   await  FirebaseFirestore.instance
        .collection('users')
        .get().then((snapshot){
        if(snapshot.docs.length>0){
          for(var doc in snapshot.docs){
             totalcount.add(User(id: doc.get('id')));
          }
        }
        });
    
    }
