import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationMag extends StatefulWidget {
  const GetLocationMag({@required this.idmag});
  final String idmag;

  @override
  _GetLocationMagState createState() => _GetLocationMagState();
}

class _GetLocationMagState extends State<GetLocationMag> {
  Position currentPosition;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  GoogleMapController googleMapController;
  String latitude, longitude;

  Future<Position> getPosition() async {
    Position position = await _determinePosition();
    currentPosition = position;
    LatLng latLng = LatLng(
      position.latitude,
      position.longitude,
    );
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 14,
    );
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        cameraPosition,
      ),
    );
    return position;
  }

  setPosition() async {
    Position position = await getPosition();
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });
    print("Les coordonnées du terrain");
    print(latitude);
    print(longitude);
    final firestore =
        FirebaseFirestore.instance.collection("Magasin").doc(widget.idmag);
    firestore.update({
      "latitude": latitude,
      "longitude": longitude,
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    getPosition();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.idmag);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(
              top: 50,
            ),
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              googleMapController = controller;
              getPosition();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setPosition();
        },
        child: Text('Push'),
      ),
    );
  }
}
