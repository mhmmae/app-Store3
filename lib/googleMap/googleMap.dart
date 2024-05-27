


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class googleMap extends StatefulWidget {
  const googleMap({super.key});

  @override
  State<googleMap> createState() => _googleMapState();
}

class _googleMapState extends State<googleMap> {

 late  StreamSubscription<Position> positionStream;


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

    }

    if(permission == LocationPermission.whileInUse ) {
       positionStream = Geolocator.getPositionStream().listen(
              (Position? position) {
           FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('location').doc(FirebaseAuth.instance.currentUser!.uid).set({
             'latitude':position!.latitude.toDouble(),
             'longitude': position.longitude.toDouble(),

           });
           controller2!.animateCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));

           print('222222222222222222222222222222');

           print('222222222222222222222222222222');
           print(position.longitude);
           print(position.latitude);
           print('222222222222222222222222222222');
           print('222222222222222222222222222222');


              });






    }

   
    return await Geolocator.getCurrentPosition();
  }


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37, -33),
    zoom: 3,
    tilt: 0,
    bearing: 0
  );

   GoogleMapController? controller2 ;


  List<Marker> markers=[];





  @override
  void initState() {
    _determinePosition();


    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    positionStream.cancel();
    // TODO: implement dispose
    super.dispose();
  }

 final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid)
     .collection('location').doc(FirebaseAuth.instance.currentUser!.uid).snapshots();


 @override
  Widget build(BuildContext context) {
   double hi = MediaQuery.of(context).size.height;
   double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body:StreamBuilder<DocumentSnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          Map<String, dynamic> user = snapshot.data!.data() as Map<String, dynamic>;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          
          markers.add(Marker(markerId: MarkerId(FirebaseAuth.instance.currentUser!.uid),position: LatLng(user['latitude'], user['longitude'])));


          return GoogleMap(
            mapType: MapType.hybrid,
            markers: markers.toSet() ,


            initialCameraPosition: CameraPosition(target: LatLng(user['latitude'], user['longitude']),zoom: 17),
            onMapCreated: ( controller) {
              controller2 = controller;
            },
          );
        },
      )
    );
  }
}
