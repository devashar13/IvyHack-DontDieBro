import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../DataProvides/models/user_data.dart';

class Helper {
  static void getCurrentUserInfo() async {
    User currentFirebaseUser = await FirebaseAuth.instance.currentUser;
    String userID = currentFirebaseUser.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('user/${userID}');
    userRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        FireUser currentUserInfo = FireUser.fromSnapshot(snapshot);
        print('it work ');
        print("My name is ${currentUserInfo.fullName}");
      }
    });
  }
}
