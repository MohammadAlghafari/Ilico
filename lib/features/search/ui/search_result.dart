import 'dart:async';
import 'dart:typed_data';

import 'package:charja_charity/core/ui/widgets/Search_Text_filled.dart';
import 'package:charja_charity/features/search/widget/marker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/widgets/view_profile_card.dart';
import '../../../core/utils/markerGenerater.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  bool isMap = false;
  bool showSearchField = false;
  Completer<GoogleMapController> _controller = Completer();
  bool isSelected = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(45.792565, 15.995832),
    zoom: 20.0,
  );
  List<Marker> markers = [];
  String imgurl = "https://www.fluttercampus.com/img/car.png";
  bool expandViewProfile = false;

  setMarker() async {
    markers.clear();
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }

  List<Widget> markerWidgets() {
    return cities.map((c) => _getMarkerWidget(c.imageUrl!)).toList();
  }

  // Example of marker widget
  Widget _getMarkerWidget(String name) {
    return MarkerItem(
      isSelected: isSelected,
    );
  }

// Example of backing data
  List<MarkerInfo> cities = [
    MarkerInfo("Zagreb", LatLng(45.792565, 15.990832),
        "https://www.fluttercampus.com/img/car.png"),
    MarkerInfo("Zagreb", LatLng(45.792565, 15.995832),
        "https://www.fluttercampus.com/img/car.png"),
    MarkerInfo("Zagreb", LatLng(45.792565, 15.999832),
        "https://www.fluttercampus.com/img/car.png"),
  ];

  mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    List<Marker> markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      final city = cities[i];
      markersList.add(Marker(
          onTap: () {
            isSelected = !isSelected;
            print("\n\n${isSelected}");
            setMarker();
            setState(() {});
          },
          markerId: MarkerId(city.title!),
          position: city.position!,
          icon: BitmapDescriptor.fromBytes(bmp)));
    });
    return markersList;
  }

  @override
  void initState() {
    setMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        backgroundColor: Colors.transparent,
        // title: "search",
        isCenterTitle: true,
        withBackButton: true,
        titleWidget: Image.asset(logoBlueIllico),
        action: [
          InkWell(
            onTap: () {
              setState(() {
                showSearchField = !showSearchField;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                search,
              ),
            ),
          ),
          isMap
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isMap = !isMap;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(listIcon),
                  ),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      isMap = !isMap;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(mapIcon),
                  ),
                ),
        ],
      ),
      body: Stack(
        children: [
          isMap
              ? Container(
                  height: 1.sh,
                  width: 1.sw,
                  color: Colors.transparent,
                  child: GoogleMap(
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.terrain,
                    initialCameraPosition: _kGooglePlex,
                    markers: markers.toSet(),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                )
              : Container(
                  height: 1.sh,
                  width: 1.sw,
                  color: Colors.white,
                ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 100.h),
            child: showSearchField
                ? const SearchTextFilled()
                : const SizedBox(
                    height: 0.01,
                    width: 0.01,
                  ),
          ),
          //Spacer(),

          const Positioned(
              bottom: 10,
              left: 25,
              child: ViewProfileCard(
                withIcon: true,
              ))
        ],
      ),
    );
  }
}

class MarkerInfo {
  String? title;
  LatLng? position;
  String? imageUrl;

  MarkerInfo(this.title, this.position, this.imageUrl);
}
