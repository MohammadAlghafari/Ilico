import 'dart:async';
import 'dart:ui' as ui;

import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/search/data/model/storeLocationModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../features/search/data/repository/search_repository.dart';
import '../../../features/search/data/usecase/store_location_usecase.dart';
import '../../constants/end_point.dart';
import '../../utils/cashe_helper.dart';
import '../widgets/Coustom_Button.dart';
import '../widgets/coustomDialog.dart';

class PopUpLocation extends StatefulWidget {
  PopUpLocation({Key? key}) : super(key: key);
  // LatLng position;

  @override
  _PopUpLocationState createState() => _PopUpLocationState();
}

class _PopUpLocationState extends State<PopUpLocation> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData? position;
  LatLng? latLng;
  final Location location = Location();
  late BitmapDescriptor myMarker;
  Marker _marker = Marker(markerId: MarkerId("2"));
  initMap() async {
    //print("${widget.position.latitude} ${widget.position.longitude}");
    String svgString = await DefaultAssetBundle.of(context).loadString(markerIcon);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width = 40 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 45 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    myMarker = BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
    //myMarker = BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
    // myMarker = await BitmapDescriptor.fromBytes(markerIcon);
    // marker added for current users location
    position = await location.getLocation();
    latLng = LatLng(position!.latitude!, position!.longitude!);
    _marker = Marker(
        markerId: const MarkerId("2"),
        position: latLng!,
        infoWindow: const InfoWindow(
          title: 'My Current Location',
        ),
        icon: myMarker);

    // specified current users location
    CameraPosition cameraPosition = CameraPosition(
      target: latLng!,
      zoom: 14,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  //Location _location = Location();
  @override
  void initState() {
    initMap();
    super.initState();

    /*  LocatedMyLocation.determinePosition().then((value) async {

    });*/
  }

  void setMarker() async {}

  @override
  Widget build(BuildContext context) {
    return CoustomDialog(
      context: context,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Fine tune your location".tr(),
            style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Please move the pin to precise your current location".tr(),
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
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onCameraMove: (CameraPosition newPosition) {
                // print(newPosition.target.toJson());
                // widget.position = newPosition.target;
                // print(widget.position);
              },
              onTap: (LatLng pos) {
                updateMarker(pos);
                latLng = pos;
                //print(widget.position);
                setState(() {});
              },
              markers: <Marker>{_marker},
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
      actionButton: Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: SizedBox(
          height: 55.h,
          // width: 114.w,
          child: CreateModel(
            withValidation: false,
            onSuccess: (StoreLocation model) async {
              CashHelper.saveData(key: LATITUDE, value: latLng!.latitude);
              CashHelper.saveData(key: LONGITUDE, value: latLng!.longitude);
              await Future.delayed(const Duration(milliseconds: 10));
              Navigation.pop();
            },
            useCaseCallBack: (model) {
              if (CashHelper.authorized && latLng != null) {
                return StoreLocationUseCase(SearchRepository())
                    .call(params: StoreLocationParams(latitude: latLng!.latitude, longitude: latLng!.longitude));
              } else if (!CashHelper.authorized && latLng != null) {
                CashHelper.saveData(key: LATITUDE, value: latLng!.latitude);
                CashHelper.saveData(key: LONGITUDE, value: latLng!.longitude);
                Navigation.pop();
              }
            },
            child: CoustomButton(
              buttonName: "Confirm my location".tr(),
              backgoundColor: AppColors.kWhiteColor,
              borderSideColor: AppColors.kPDarkBlueColor,
              borderRadius: 10.0,
              width: 249.w,
            ),
          ),
        ),
      ),
    ); /*AppDialog(
      buildContext: context,
      //   cancel: "Cancel",
      Confirm: "Confirm my location",
      btnWidth: 249.w,
      // height: 504.h,
      function: () {
        CashHelper.saveData(key: LATITUDE, value: widget.position.latitude);
        CashHelper.saveData(key: LONGITUDE, value: widget.position.longitude);
        // Navigator.pop(context);
        //TODO add end point foe store Location
        print(widget.position);
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
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onCameraMove: (CameraPosition newPosition) {
                // print(newPosition.target.toJson());
                // widget.position = newPosition.target;
                // print(widget.position);
              },
              onTap: (LatLng pos) {
                updateMarker(pos);
                widget.position = pos;
                print(widget.position);
                setState(() {});
              },
              markers: <Marker>{_marker},
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
    ).showDialog(context);*/
  }

  updateMarker(position) {
    //final marker = _markers.values.toList().firstWhere((item) => item.markerId == id);
    Marker marker = Marker(
      markerId: MarkerId("2"),
      onTap: () {
        print("tapped");
      },
      position: LatLng(position.latitude, position.longitude),
      icon: myMarker,
      infoWindow: InfoWindow(title: 'My Current Location'),
    );
    latLng = LatLng(position.latitude, position.longitude);
    setState(() {
      //the marker is identified by the markerId and not with the index of the list
      _marker = marker;
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(45.792565, 15.995832),
    zoom: 20.0,
  );
}
