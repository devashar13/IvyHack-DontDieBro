import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Helper {
  static void getCurrentUserInfo() async {
    User currentFirebaseUser = await FirebaseAuth.instance.currentUser;
    String userID = currentFirebaseUser.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/${userID}');
    userRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {}
    });
  }
}
