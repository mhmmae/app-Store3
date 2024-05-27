
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../googleMap/GoogleMapOrder.dart';
import '../googleMap/googleMap.dart';

class theChosen extends StatefulWidget {
  const theChosen({super.key,});

  @override
  State<theChosen> createState() => _theChosenState();
}

class _theChosenState extends State<theChosen> {

 final Stream<DocumentSnapshot<Map<String, dynamic>>>? personnalData = FirebaseFirestore
      .instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();


  final Stream<QuerySnapshot> cardItem = FirebaseFirestore.instance
      .collection('the-chosen')
      .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();


  ItemUid(String ItemUid2) {
  return  FirebaseFirestore.instance
        .collection('Item')
        .doc(ItemUid2)
        .get();
  }

   DeleteItem(String uidDoc){
    return  FirebaseFirestore.instance.collection('the-chosen').doc(uidDoc).delete();

  }
 late  StreamSubscription<Position> positionStream;
  send()async{
    double? longitude2;
    double? latitude2;



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

    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always) {


      await Geolocator.getCurrentPosition().then((value){
        print('2222222222222222222222');
        print(value.longitude);
        print(value.latitude);
        print('2222222222222222222222');

        setState(() {
          latitude2 =value.latitude;
          longitude2= value.longitude;

        });



      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapOrder(longitude: longitude2!,latitude: latitude2!,)));






    }


    return   await Geolocator.getCurrentPosition();








    // try{await FirebaseFirestore.instance
    //     .collection('the-chosen')
    //     .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) async{
    //
    //     await FirebaseFirestore.instance.collection('order').doc(doc['uidOfDoc']).set({
    //       'uidUser': doc['uidUser'],
    //       'uidItem': doc['uidItem'],
    //       'uidOfDoc':doc['uidOfDoc'],
    //       'number':doc['number'],
    //
    //     }).then((value)async{
    //        await FirebaseFirestore.instance.collection('order').doc(FirebaseAuth.instance.currentUser!.uid)
    //            .collection('location')
    //            .doc(FirebaseAuth.instance.currentUser!.uid)
    //           .set({});
    //     });
    //
    //     print(doc["uidOfDoc"]);
    //   });
    // });
    // }catch(e){}
    //
    //


  }





@override
Widget build(BuildContext context) {
  double hi = MediaQuery.of(context).size.height;
  double wi = MediaQuery.of(context).size.width;
    return Scaffold(

        extendBodyBehindAppBar: true,
        body: Column(children: [
                  Container(
        height:hi/8,
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: hi/20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_backspace,
                          size: wi/13,
                        ),
                      ),
                      SizedBox(
                        width: wi/20,
                      ),
                      Text(
                        'card',
                        style: TextStyle(fontSize: wi/23),
                      )
                    ],
                  ),
                  Icon(
                    Icons.dehaze_rounded,
                    size: wi/14,
                  )
                ],
              ),
            ],
          ),
        ),
                  ),
                  Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
            color: Colors.black12, borderRadius: BorderRadius.circular(15)),
        height: hi/1.47,
        child:
            StreamBuilder<DocumentSnapshot>(
              stream: personnalData,
              builder: (BuildContextcontext,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                Map<String, dynamic> data1 =
                    snapshot.data!.data() as Map<String, dynamic>;
                return  ListView(
                  shrinkWrap: true,
                  primary: true,


                  children: [


                    Container(


                      height:hi/1.49,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: cardItem,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text('OJPOJP');
                            }

                            return snapshot.data!.docs.isNotEmpty
                                ? ListView(
                              shrinkWrap: true,
                              primary: true,

                                    children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data3 = document
                                    .data()! as Map<String, dynamic>;
                                return FutureBuilder<DocumentSnapshot>(
                                  future: ItemUid(data3['uidItem']),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                      snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Something went wrong");
                                    }

                                    if (snapshot.hasData &&
                                        !snapshot.data!.exists) {
                                      return Text(
                                          "Document does not exist");
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      Map<String, dynamic> data =
                                      snapshot.data!.data()
                                      as Map<String, dynamic>;
                                      return
                                        Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                          child: Container(
                                            width: double.infinity,
                                            height: hi/8.8,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(color: Colors.black38)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(width: wi/46,),
                                                    Padding(
                                                      padding: const EdgeInsets.all(1),
                                                      child: Image.network(data['url']),
                                                    ),
                                                    SizedBox(width: wi/26,),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(data['nameOfItem'],style: TextStyle(fontSize: wi/30),),
                                                          Text(data['priceOfItem'],style: TextStyle(fontSize: wi/35),)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      GestureDetector(
                                                          onTap: (){DeleteItem(data3['uidOfDoc'].toString());},
                                                          child: Icon(Icons.delete_forever,color: Colors.red,)),
                                                      Row(
                                                        children: [
                                                          addAndRemoe(number: data3['number'],
                                                            uidItem: data3['uidItem'],
                                                            uidOfDoc: data3['uidOfDoc'],),
                                                          SizedBox(width:wi/15,)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),




                                              ],
                                            ),
                                          ),);

                                    }

                                    return Text("loading");
                                  },
                                );
                                                              }).toList(),
                                                            )
                                : Container();
                          }),

                    ),



                  ],

                );
              },
            ),



                  ),

                  Container(
        width: double.infinity,
        height: hi/5.23,
        color: Colors.white10,
        child: Column(
          children: [
            SizedBox(
              height: 2,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: wi/20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'total:',
                    style: TextStyle(
                        fontSize: wi/18, color: Colors.deepPurpleAccent),
                  ),
                  Text(
                    '25,000',
                    style: TextStyle(
                        fontSize: wi/20, color: Colors.deepPurpleAccent),
                  )
                ],
              ),
            ),
            SizedBox(
              height: hi/50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: GestureDetector(
                onTap: (){send();},
                child: Container(
                  width: double.infinity.w,
                  height: hi/14,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(child: Text('ارسال الطلب',style: TextStyle(fontSize: wi/20),)),
                ),
              ),
            )
          ],
        ),
                  )
                ]
        )
    );
  }
}

class addAndRemoe extends StatefulWidget {
  int number;
  String uidOfDoc;
  String uidItem;


  addAndRemoe({super.key, required this.number,required this.uidItem,required this.uidOfDoc});

  @override
  State<addAndRemoe> createState() => _addAndRemoeState();
}

class _addAndRemoeState extends State<addAndRemoe> {

  addItem2() {

    try {
      widget.number++;

      if (widget.number == 1) {
        FirebaseFirestore.instance.collection('the-chosen').doc(widget.uidOfDoc).set({
          'uidUser': FirebaseAuth.instance.currentUser!.uid,
          'uidItem': widget.uidItem,
          'uidOfDoc': widget.uidOfDoc,
          'number': widget.number
        });
      } if (widget.number > 1) {
        FirebaseFirestore.instance
            .collection('the-chosen')
            .doc(widget.uidOfDoc)
            .set({
          'uidUser': FirebaseAuth.instance.currentUser!.uid,
          'uidItem': widget.uidItem,
          'uidOfDoc':widget.uidOfDoc,
          'number': widget.number
        });
      }


    } catch (e) {}
  }



  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){addItem2();},
            child: Container(child: Center(child: Icon(Icons.add,size: wi/22,)),
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(16)
            ),height: hi/30,width: wi/16,
            ),
          ),
          SizedBox(width: wi/60,),
          Text('${widget.number}',style: TextStyle(fontSize: wi/26),),
          SizedBox(width:  wi/60,),


          GestureDetector(
            onTap: (){},
            child: Container(child: Center(child: Icon(Icons.remove,size:wi/22,)),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(16)
              ),height: hi/30,width: wi/16,
            ),
          ),
        ],
      ),
    );
  }
}
