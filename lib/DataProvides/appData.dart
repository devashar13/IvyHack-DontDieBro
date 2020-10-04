import 'package:DontDieBro/DataProvides/models/dataModel.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AppData extends ChangeNotifier {
  Address coords;
  void updateCoords(Address address) {
    coords = address;
    notifyListeners();
  }
}
