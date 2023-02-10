import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../ui/dialogs/locatedPermissionDialog.dart';
import '../ui/dialogs/popup_Location.dart';
import 'Keys.dart';

class LocatedMyLocation {
  static Future<void> determinePosition() async {
    final Location location = Location();
    bool serviceEnabled;
    // PermissionStatus permissionGranted;
    // LocationData? locationData;

    PermissionStatus hasPermissions = await location.hasPermission();
    if (hasPermissions != PermissionStatus.granted || hasPermissions != PermissionStatus.grantedLimited) {
      await location.requestPermission();
    }
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      showDialog(
          context: Keys.navigatorKey.currentState!.context,
          builder: (context) {
            return LocatedPermissionDialog(
              function: () async {
                bool isEnabledLocation = await location.requestService();
                // serviceEnabled = await Geolocator.isLocationServiceEnabled();
                print("Location is enable:$isEnabledLocation");
                if (isEnabledLocation) {
                  Navigation.pop();

                  showDialog(
                      barrierDismissible: false,
                      context: Keys.navigatorKey.currentState!.context,
                      builder: (context) {
                        return PopUpLocation(
                            //  position: LatLng((locationData?.latitude)!, (locationData?.longitude)!),
                            );
                      });
                  print("Location is enable");
                  // Navigation.pop();
                } else {
                  //  Navigation.pop();
                }
              },
            );
          });
    } else {

      showDialog(
          barrierDismissible: false,
          context: Keys.navigatorKey.currentState!.context,
          builder: (context) {
            return PopUpLocation(
                //  position: LatLng((locationData?.latitude)!, (locationData?.longitude)!),
                );
          });
    }

  }
  // return null;

}
