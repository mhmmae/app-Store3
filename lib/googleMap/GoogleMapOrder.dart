


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oscar/HomePage/home/home.dart';

import '../theـchosen/theـchosen.dart';

class GoogleMapOrder extends StatefulWidget {
  double longitude;
  double latitude;
   GoogleMapOrder({super.key,required this.longitude,required this.latitude});

  @override
  State<GoogleMapOrder> createState() => _GoogleMapOrderState();
}

class _GoogleMapOrderState extends State<GoogleMapOrder> {
  late  StreamSubscription<Position> positionStream;
  
  bool isloding = false;



 areYouShor() async {

   try{
     return showDialog<void>(barrierDismissible: true,context: context, builder: (BuildContext context){
       return AlertDialog(
         actions: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GestureDetector(onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>theChosen()));
                 }
                     ,child: Text('الغاء الطلب',style: TextStyle(color: Colors.redAccent,fontSize: 17,fontWeight: FontWeight.w600),)),

                 GestureDetector(onTap: ()async{

                   try{
                     setState(() {
                       isloding=true;
                     });
                     await FirebaseFirestore.instance
                       .collection('the-chosen')
                       .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                       .get()
                       .then((QuerySnapshot querySnapshot) {
                     querySnapshot.docs.forEach((doc) async{

                       await FirebaseFirestore.instance.collection('order').doc(doc['uidOfDoc']).set({
                         'uidUser': doc['uidUser'],
                         'uidItem': doc['uidItem'],
                         'uidOfDoc':doc['uidOfDoc'],
                         'number':doc['number'],

                       }).then((value)async{
                          await FirebaseFirestore.instance.collection('order').doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('location')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                             .set({
                            'longitude': widget.longitude,
                            'latitude':widget.latitude

                          });
                       }).then((value) async{

                         await FirebaseFirestore.instance.collection('the-chosen')
                             .doc(doc['uidOfDoc']).delete();
                         setState(() {
                           isloding =false;
                         });

                         Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                       }).then((vvv){
                         FirebaseMessaging.instance.requestPermission();
                       });


                     });
                   });
                   }catch(e){}



                 }
                     ,child: Text('ارسال الطلب',style: TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.w700),)),


               ],
             ),
           )

         ],
         
         title:isloding?Center(child: CircularProgressIndicator()): Text('هل انت متآكد من ارسال الطلب',textAlign: TextAlign.center,),
         content: Text('لا يمكن التراجع عن ارسال الطلب   ',textAlign: TextAlign.center,),
       );});
   }catch(e) {}


  }

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33, -33),
      zoom: 3,
      tilt: 0,
      bearing: 0
  );

  GoogleMapController? controller2 ;





 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
   List<Marker> markers=[
    Marker(markerId: MarkerId('1'),position: LatLng(widget.latitude,widget.longitude))
  ];
    return Scaffold(
      body:isloding?Align(alignment: Alignment.topCenter,child: CircularProgressIndicator()):  Stack(
        children: [

          GoogleMap(
            mapType: MapType.hybrid,
            markers: markers.toSet() ,

            onTap: (LatLng){
              setState(() {
                widget.longitude =LatLng.longitude;
                widget.latitude =LatLng.latitude;
              });
            },


            initialCameraPosition:  CameraPosition(target: LatLng(widget.latitude,widget.longitude),zoom: 17),
            onMapCreated: ( controller) {
              controller2 = controller;
            },
          ),
          Positioned(top:hi/17 ,left: wi/20,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                },
            child: Container(
              width: wi/4,
              height: hi/22,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(200),bottomLeft: Radius.circular(200)),
                color: Colors.red
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.home,size: 40,),
                    Icon(Icons.arrow_back,size: 33,),

                  ],
                ),
              ),
            ),
          )),
          Positioned(bottom: hi/70,right: wi/60,left: wi/60,
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: GestureDetector(
                  onTap: (){areYouShor();},
                  child: Container(
                    width: wi,
                    height: hi/14,
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(child: Text('ارسال الطلب',style: TextStyle(fontSize: wi/20),)),
                  ),
                ),
              ))
        ],
      )
    );
  }
}
