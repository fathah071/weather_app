import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends ChangeNotifier {
  String latitude = "11.2588";
  String longtitude = "75.7804";

  bool isPermissionGranted = false;

//function to request location permission
  requestLocationPermission() async {
    print("req pos");
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
  }

//function fetch user cuurent location
  getposition() async {
    print("get pos");
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    notifyListeners();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      isPermissionGranted == true;
      notifyListeners();
    }
    if (permission == LocationPermission.deniedForever) {
      isPermissionGranted == true;
      notifyListeners();
    }
    Position currentposition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );
    notifyListeners();
    latitude = currentposition.latitude.toString();
    longtitude = currentposition.longitude.toString();
    print("done");

    isPermissionGranted = true;
    notifyListeners();
    print(latitude);
    print("lat--" + currentposition!.latitude.toString());
    print("lon--" + currentposition!.longitude.toString());

    if (currentposition == null) {
      isPermissionGranted == true;
      notifyListeners();
    }
    print(isPermissionGranted);
  }
}
