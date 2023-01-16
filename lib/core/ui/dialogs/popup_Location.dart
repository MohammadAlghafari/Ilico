import 'dart:async';

import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/dialogs/app_dialog.dart';
import '../../utils/Navigation/Navigation.dart';

class PopUpLocation extends StatefulWidget {
  const PopUpLocation({Key? key, required this.position}) : super(key: key);
  final Position position;

  @override
  _PopUpLocationState createState() => _PopUpLocationState();
}

class _PopUpLocationState extends State<PopUpLocation> {
  Completer<GoogleMapController> _controller = Completer();
  //Position? position;
  late BitmapDescriptor myMarker;
  final List<Marker> _markers = <Marker>[];
  initMap() async {
    print("${widget.position.latitude} ${widget.position.longitude}");
    myMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(30.w, 44.h)), logo);
    // marker added for current users location
    _markers.add(Marker(
        markerId: const MarkerId("2"),
        position: LatLng(widget.position.latitude, widget.position.longitude),
        infoWindow: const InfoWindow(
          title: 'My Current Location',
        ),
        icon: myMarker));

    // specified current users location
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(widget.position.latitude, widget.position.longitude),
      zoom: 14,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  //Location _location = Location();
  @override
  void initState() {
    super.initState();
    initMap();
    /*  LocatedMyLocation.determinePosition().then((value) async {

    });*/
  }

  void setMarker() async {}

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      buildContext: context,
      //   cancel: "Cancel",
      Confirm: "Confirm my location",
      btnWidth: 249.w,
      // height: 504.h,
      function: () {
        // Navigator.pop(context);
        Navigation.pop();
      },
      isHaveCancel: false,
      //true to show cancel button
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Fine tune your location",
            style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Please move the pin to precise your current location",
            textAlign: TextAlign.center,
            style: AppTheme.headline5.copyWith(color: AppColors.kDimBlue),
          ),
          SizedBox(
            height: 27.h,
          ),
          SizedBox(
            height: 291.h,
            child: GoogleMap(
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.terrain,
              initialCameraPosition: _kGooglePlex,
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
        ],
      ),
    ).showDialog(context);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(45.792565, 15.995832),
    zoom: 20.0,
  );
}
