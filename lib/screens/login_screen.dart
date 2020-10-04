import 'package:DontDieBro/screens/mainpage.dart';
import 'package:DontDieBro/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:location/location.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void login() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('user/${user.uid}');
      userRef.once().then((DataSnapshot) => {
            if (DataSnapshot.value != null)
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, MainPage.id, (route) => false)
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'yourEmail@xyz.com',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'password',
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          var connectiviyResult =
                              await Connectivity().checkConnectivity();
                          if (connectiviyResult != ConnectivityResult.mobile &&
                              connectiviyResult != ConnectivityResult.wifi) {
                            showSnackBar('No internet connectivity');
                            return;
                          }
                          if (emailController.text.contains('@')) {
                            showSnackBar('Enter valid Email');
                          }
                          if (passwordController.text.length < 8) {
                            showSnackBar('Enter valid password');
                          }
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25),
                        ),
                        color: Colors.red[400],
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RegistrationScreen.id, (route) => false);
                    },
                    child: Text(
                      'Dont have an account sign up here',
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
