import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Location location = new Location();

  void setUpPositionLocator() async {
    var pos = await location.getLocation();
    print(pos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Main Page'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: GestureDetector(
              onTap: () {
                setUpPositionLocator();
              },
              child: ClipOval(
                child: Container(
                  color: Colors.red[400],
                  height: 150,
                  width: 150,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(' SOS',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
