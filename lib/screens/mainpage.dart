import 'package:DontDieBro/DataProvides/appData.dart';
import 'package:DontDieBro/DataProvides/models/user_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import '../DataProvides/models/dataModel.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../DataProvides/helper.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future setUpPositionLocator() async {
    Location location = new Location();
    var pos = await location.getLocation();
    print(pos);
    Address coords = new Address();
    coords.longitude = pos.longitude;
    coords.latitude = pos.latitude;
    Provider.of<AppData>(context, listen: false).updateCoords(coords);
  }

  FireUser currentFireUser;
  DatabaseReference helpRef;

  Future createRequest() async {
    Location location = new Location();
    var pos = await location.getLocation();
    helpRef = FirebaseDatabase.instance.reference().child('helpRequest').push();
    print('my sex name is ${currentFireUser.fullName}');
    var loc = Provider.of<AppData>(context, listen: false).coords;
    Map help = {
      'created_at': DateTime.now().toString(),
      'name': currentFireUser.fullName,
      'phone': currentFireUser.phone,
      'latitude': pos.latitude,
      'longitude': pos.longitude,
    };
    helpRef.set(help);
  }

  @override
  void initState() {
    setUpPositionLocator();
    Helper.getCurrentUserInfo();
    super.initState();
  }

  Widget getSheet() {}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: GestureDetector(
                onTap: () {
                  createRequest();
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 400,
                              decoration: BoxDecoration(
                                  color: Colors.red[400],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 15.0,
                                      spreadRadius: 0.5,
                                      offset: Offset(
                                        0.7,
                                        0.7,
                                      ),
                                    )
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextLiquidFill(
                                      text: 'Sending SOS',
                                      waveColor: Colors.white,
                                      boxBackgroundColor: Colors.red[400],
                                      textStyle: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      boxHeight: 190.0,
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        FloatingActionButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons.cancel),
                                          backgroundColor: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
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
          ),
        ],
      ),
    );
  }
}
