import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../ui/dialogs/locatedPermissionDialog.dart';
import 'Keys.dart';

class LocatedMyLocation {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //TODO add Locatied permisson popup
      showDialog(
          context: Keys.navigatorKey.currentState!.context,
          builder: (context) {
            return LocatedPermissionDialog();
          });
      Navigation.pop();
      //return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
    // print(locationController.position[0].)

    //return locationController.position;
  }
}
