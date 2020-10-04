import 'package:firebase_database/firebase_database.dart';

class FireUser {
  String fullName;
  String email;
  String phone;
  String id;

  FireUser({
    this.email,
    this.fullName,
    this.phone,
    this.id,
  });
  FireUser.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    email = snapshot.value['email'];
    fullName = snapshot.value['fullName'];
    phone = snapshot.value['phone'];
  }
}
