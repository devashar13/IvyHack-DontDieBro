import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../DataProvides/models/user_data.dart';

class Helper {
  static void getCurrentUserInfo() async {
    User currentFirebaseUser = await FirebaseAuth.instance.currentUser;
    String userID = currentFirebaseUser.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$userID');
    userRef.once().then((DataSnapshot snapshot) {
      FireUser currentUserInfo = FireUser.fromSnapshot(snapshot);
      print(currentUserInfo.id);
      print('it work ');
      print("My name is ${currentUserInfo.fullName}");
    });
  }
}
