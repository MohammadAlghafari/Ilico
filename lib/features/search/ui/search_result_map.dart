import 'dart:async';
import 'dart:typed_data';

import 'package:charja_charity/core/constants/end_point.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/ui/widgets/Search_Text_filled.dart';
import '../../../core/ui/widgets/view_profile_card.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/markerGenerater.dart';
import '../data/model/search_model.dart';
import '../widget/marker_widget.dart';

class SearchResultMap extends StatefulWidget {
  const SearchResultMap({Key? key, required this.type, required this.searchResult, required this.showSearchField})
      : super(key: key);
  final List<SearchOfServiceProvider> searchResult;
  final bool showSearchField;
  final String type;

  @override
  _SearchResultMapState createState() => _SearchResultMapState();
}

class _SearchResultMapState extends State<SearchResultMap> {
  bool isMap = true;
  bool showSearchField = false;
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(CashHelper.getData(key: LATITUDE), CashHelper.getData(key: LONGITUDE)),
    zoom: 15.0,
  );

  bool expandViewProfile = false;

  List<Widget> markerWidgets() {
    return widget.searchResult.map((e) => _getMarkerWidget(e)).toList();
  }

  Widget _getMarkerWidget(SearchOfServiceProvider serviceItem) {
    return MarkerItem(
      serviceItem: serviceItem,
      isSelected: serviceItem.isSelected,
    );
  }

  late List<MapMarker> marker = [];
  List<Marker> googleMarkers = [];

  void getMarker() async {
    googleMarkers.clear();
    List<Widget> temp = markerWidgets();

    for (Widget markerWidget in temp) {
      var tempBitmap;
      CustomMarkerGenerator(markerWidget, (p0) {
        setState(() {
          tempBitmap = mapBitMapToMarkers(p0, temp.indexOf(markerWidget));
        });
      }).generate(context);
    }
  }

  mapBitMapToMarkers(Uint8List pitMap, int index) {
    final serviceProviderItem = widget.searchResult[index];
    if (serviceProviderItem.generalInformation!.latitude != null &&
        serviceProviderItem.generalInformation!.longitude != null) {
      marker.add(
        MapMarker(
          onTap: () {
            widget.searchResult.forEach((element) {
              if (element.isSelected) {
                element.isSelected = false;
              }
            });
            serviceProviderItem.isSelected = !serviceProviderItem.isSelected;
            getMarker();
            setState(() {});
          },
          id: serviceProviderItem.id!,
          position: LatLng(
              serviceProviderItem.generalInformation!.latitude!, serviceProviderItem.generalInformation!.longitude!),
          icon: BitmapDescriptor.fromBytes(pitMap),
        ),
      );
    }
    final Fluster<MapMarker> fluster = Fluster<MapMarker>(
        minZoom: 0, // The min zoom at clusters will show
        maxZoom: 10, // The max zoom at clusters will show
        radius: 150, // Cluster radius in pixels
        extent: 2048, // Tile extent. Radius is calculated with it.
        nodeSize: 64, // Size of the KD-tree leaf node.
        points: marker, // The list of markers created before
        createCluster: (
          // Create cluster marker
          BaseCluster? cluster,
          double? lng,
          double? lat,
        ) {
          print(cluster);
          print(
            LatLng(lat!, lng!),
          );
          return MapMarker(
            onTap: marker.elementAt(cluster!.index!).onTap,
            id: cluster.id.toString(),
            position: LatLng(lat, lng),
            icon: BitmapDescriptor.fromBytes(pitMap),
            isCluster: cluster.isCluster,
            clusterId: cluster.id,
            pointsSize: cluster.pointsSize,
            childMarkerId: cluster.childMarkerId,
          );
        });
    setState(() {});
    googleMarkers = fluster.clusters([-180, -85, 180, 85], 20).map((cluster) => cluster.toMarker()).toList();
  }

  @override
  void initState() {
    widget.searchResult.first.isSelected = true;
    getMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 1.sh,
          width: 1.sw,
          color: Colors.transparent,
          child: GoogleMap(
            zoomGesturesEnabled: true,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            markers: googleMarkers.toSet(),
            initialCameraPosition: CameraPosition(
              target: LatLng(CashHelper.getData(key: LATITUDE), CashHelper.getData(key: LONGITUDE)), //todo
              zoom: 15,
            ),
            mapToolbarEnabled: false,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          color: Colors.transparent,
          margin: EdgeInsets.only(top: 100.h),
          child: widget.showSearchField
              ? SearchTextFilled(
                  isShowFilter: false,
                  onTap: () {
                    Navigation.pop();
                  },
                )
              : const SizedBox(
                  height: 0.01,
                  width: 0.01,
                ),
        ),
        //Spacer(),

        Positioned(
            bottom: 10,
            left: 25,
            child: ViewProfileCard(
              type: widget.type,
              searchOfServiceProvider: widget.searchResult.firstWhere((element) => element.isSelected),
              withIcon: true,
              isInfluencer: false,
            ))
      ],
    );
  }
}

class MapMarker extends Clusterable {
  final String id;
  final LatLng position;
  final BitmapDescriptor icon;
  GestureTapCallback? onTap;

  MapMarker({
    this.onTap,
    required this.id,
    required this.position,
    required this.icon,
    isCluster = false,
    clusterId,
    pointsSize,
    childMarkerId,
  }) : super(
          markerId: id,
          latitude: position.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );
  Marker toMarker() => Marker(
        onTap: onTap,
        markerId: MarkerId(id),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: icon,
      );
}
