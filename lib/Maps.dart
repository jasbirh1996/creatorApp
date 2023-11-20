import 'dart:async';

import 'package:creator/utils/AppColor.dart';
import 'package:creator/utils/AppComponents.dart';
import 'package:creator/utils/AppFonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'onBoarding/controller/ResturantDetailController.dart';


class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapState();
}

class _MapState extends State<Maps> {

  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  var basePosition = const LatLng(28.7041, 77.1025);
  var currentPosition;
  final Completer<GoogleMapController> _mapController = Completer();
  var googleMapController;
  var controller = Get.put(ResturentDetailController());

  var locationLatLng = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    var _currentLocation = await _determinePosition();
    setState(() {
      currentPosition =
          LatLng(_currentLocation.latitude, _currentLocation.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [

                GoogleMap(
                  markers: Set<Marker>.of(_markers.values),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: currentPosition ?? basePosition,
                    // Update with your initial location
                    zoom: 15.0,
                  ),
                  myLocationEnabled: false,
                  onTap: (LatLng position) {
                    // _launchGoogleMaps(position);
                  },
                  onCameraMove: _onCameraMove,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 60,
                    color: Colors.black,
                    child: Row(
                      children: [
                        SizedBox(width: 8,),
                       InkWell(
                         onTap: (){
                           Navigator.of(context).pop();
                         },
                           child: AppComponents.backButton()),
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.1,),
                          child:  const Text(
                            "My Location",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.montserratSemibold,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                        ),
                      ],
                    )
                  ),
                ),
                 Center(
                  child: Image.asset("assets/images/location_pin.png",
                  width: 70,height: 70,)
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                            decoration: const BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            //margin: const EdgeInsets.all(10),
                            padding:  EdgeInsets.all(10),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16,right: 16),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8,),
                                        const Text("  Your Location",style: TextStyle(color: Colors.white,
                                            fontFamily: AppFonts.montserratSemibold,
                                            fontSize: 16
                                        ),),
                                        SizedBox(height: 19,),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_rounded,color: AppColors.white,),
                                            SizedBox(width: 8,),
                                            Expanded(
                                              child: Text("$locationLatLng",
                                                softWrap: true,

                                                  overflow: TextOverflow.ellipsis,
                                                style: TextStyle(color: Colors.white,
                                                    fontFamily: AppFonts.montserratMedium,
                                                    fontSize: 14
                                                ),),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  AppComponents.createButton("Confirmed", () {

                                    controller.mapLocation.value = locationLatLng;
                                    Navigator.of(context
                                    ).pop();

                                  }),
                                  SizedBox(height: 8,)
                                ]
                              ),
                            )

                        ),

                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    currentPosition = position.target;

    getAddress(position);
  }

  getAddress(CameraPosition position) async {
    placemarkFromCoordinates(
        position.target.latitude, position.target.longitude)
        .then((placemarks) {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        var locality = placemarks[0].locality ?? "Locality" ;
        var street = placemarks[0].street ?? "Street";
        var postalCode = placemarks[0].postalCode ?? "PostalCode";
        var country = placemarks[0].country ?? "Country";
        var sublocality = placemarks[0].subLocality ?? "SubLocality";


        setState(() {
          currentPosition =
              LatLng(position.target.latitude, position.target.longitude);
          locationLatLng = "$locality , $street";

        });
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    ///googleMapController = controller;
    _mapController.complete(controller);

    // Add your marker initialization logic here if needed
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

/*
  void _launchGoogleMaps(LatLng position) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch Google Maps';
    }
  }
*/
}
