import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oscar/controler/local-notification-onroller.dart';
import 'package:oscar/ddd.dart';
import 'package:uuid/uuid.dart';

import '../../theـchosen/theـchosen.dart';
import '../../widget/TextFormFiled.dart';
import 'package:http/http.dart' as http;


class home extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  // @pragma("vm:entry-point")
  //  Future <void> onNotificationCreatedMethod2(ReceivedNotification receivedNotification,BuildContextcontext) async {
  //   print('123456789012345678901234567891234567890');
  //   print('123456789012345678901234567891234567890www');
  //   print('123456789012345678901234567891234567890xcdee');}
  //




  TextEditingController search = TextEditingController();


  late PageController pageController;


  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Item').snapshots();

  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('user');


  int corintPage = 0;


  final Stream<QuerySnapshot> cardItem = FirebaseFirestore.instance
      .collection('the-chosen')
      .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();




  ccc2()async{
    var data1 ={
      'to' :'fBn1g5SkQiO9RNWVpA6swE:APA91bGJzOBtwwzHrbelXTlEQGBqJKuVeMNwdxpL4-tZ6NF3Eb4zlsbJQaXNX_X8nclZfYcoHSZf2iRBvlIo8V5UNW6dC4JOngvMDo5e_73CFbmMw41taTT8UDkeXsffzNZD4MVJsBpq',
      'priority':'high',
      'notification':{
        'title':'momo',
        'body':'jkjkhljk'
      }
    };


    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
    body: jsonEncode(data1),
    headers: {
      'Content-Type' :'application/json; charset=UTF-8',
      'Authorization' :'key=AAAAugqtCBo:APA91bG8694ZucZREL9-mxwn6NlU4OL-9zl-nhsUVHrMk5f3EMuIHIZFXypsqmyibDVSK4jbkaQe4FirE215iHc4dzLbYyb79KAdwuYuA3VZO8wetTQV3Ps1pA5LyKS1PSbjzr1FTh7l'
    });




    FirebaseMessaging.instance.getToken().then((val){
      print('123456789012345678901234567891234567890');
      print(val);
      print('123456789012345678901234567891234567890');

    });
  }

  ccc()async{
    localNotification.showNotofication();

  }

  @override
  void initState() {
    // TODO: implement initState




    // setup(context);


    pageController = PageController(
          initialPage: corintPage,
        );
     // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
     //   if (!isAllowed) {
     //     AwesomeNotifications().requestPermissionToSendNotifications();
     //   }
     // });
     //
     // FirebaseMessaging.onMessage.listen((RemoteMessage message ){
     //   AwesomeNotifications().createNotification(
     //     content: NotificationContent(
     //
     //       color: Colors.red,
     //
     //
     //       id: 10,
     //       largeIcon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIPaZuF36QU4wzIjUyMixqgQrJR22Q-TAhTjrEY-1vfQ&s',
     //
     //       chronometer: const Duration(seconds: 5),
     //
     //
     //
     //       notificationLayout: NotificationLayout.Messaging,
     //       roundedLargeIcon: true,
     //
     //       channelKey: 'basic_channel',
     //       fullScreenIntent: true,
     //
     //       actionType: ActionType.DisabledAction,
     //       title: message.notification!.title.toString(),
     //       body: message.notification!.body.toString(),
     //     ),
     //
     //   );
     //   print('777777777777777777777777777777777777');
     //
     //
     //   print(message.threadId);
     //   print(message..sentTime);
     //   print(message.senderId.toString());
     //   print(message.from.toString());
     //   print('777777777777777777777777777777777777');
     //
     //
     //
     // });
     //
     // FirebaseMessaging.instance.getToken().then((val){
     //   print('123456789012345678901234567891234567890');
     //   print(val);
     //   print('123456789012345678901234567891234567890');
     //
     // });
     //
     //
     //
     //


    

     super.initState();

  }




  // Future<void> setup(BuildContext context)async{
  //   RemoteMessage? inti =await FirebaseMessaging.instance.getInitialMessage();
  //
  //   if(inti !=null){
  //     hundl(context, inti);
  //
  //   }
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((onData){
  //     hundl(context, onData);
  //
  //   });
  //
  // }
  //
  // void hundl(BuildContext context,RemoteMessage massege){
  //
  //
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>eee()));
  //
  // }


  @override
  void dispose() {
    // TODO: implement dispose
     pageController.dispose();
    super.dispose();

  }

// FirebaseFirestore.instance.collection('the-chosen').where('uidUser',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    print(hi);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: wi/1.25,
        leading:Padding(
          padding: const EdgeInsets.only(left: 10,top: 0),
          child: TextFormFiled2(
            wight: wi/1.25,
            fontSize: hi/60,
            height: hi/40,
            borderRadius: 12,
            controller: search,
            validator: (val) {
              if (val == null) {
                return 'Eimpety';
              }
              return null;
            },
            label: 'Search ',
            obscure: false,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: StreamBuilder<QuerySnapshot>(
              stream: cardItem,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('OJPOJP');
                }

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> theChosen()));
                  },
                  child: Row(children: [
                    snapshot.data!.docs.isNotEmpty
                        ? Container(
                        width: wi/9,
                        height: hi/18,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Badge(
                              child: Icon(
                                Icons.card_travel_sharp,
                                size: wi/12,
                              ),
                              largeSize: wi/12,
                            )))
                        : Icon(
                      Icons.card_travel_sharp,
                    )
                  ]),
                );
              },
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: hi/50,
          ),


          StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('OJPOJP');
              }

              return SizedBox(
                height: hi/3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DocumentSnapshot dede = snapshot.data!.docs[index];

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          children: [
                            Container(

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12))),
                              width: double.infinity,
                              height: hi/28,
                              child: Center(
                                  child: Text(
                                    dede['descriptionOfItem'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: hi/50,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic),
                              )),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: wi/3.3,
                                  height: hi/3.4,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12))),
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        height: hi/10,
                                        child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Text(
                                                                                        '100% OFF',
                                                                                        style: TextStyle(
                                                color: Colors.black,
                                                fontSize: hi/40,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                                                                      ),
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          ccc();
                                        },
                                        child: Container(
                                          color: Colors.blueAccent,
                                          width: double.infinity,
                                          height: hi/12,
                                          child: Center(
                                              child: Text(
                                            '100000',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: hi/50,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          print('12345678901234567890-123456789');
                                          print(hi);
                                          print(wi);
                                          print('12345678901234567890-123456789');


                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          width: double.infinity,
                                          height: hi/9.6,
                                          child:  Center(
                                              child: Text(
                                            'الآن 2000',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: hi/47,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12)),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(dede['url']),
                                        ),
                                      ),
                                      width: wi/2,
                                      height:hi/3.4,
                                      child: Text(dede['descriptionOfItem'])),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: hi/22,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: GridView.builder(
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    childAspectRatio:hi/1800,
                      crossAxisSpacing: hi/150,
                      mainAxisSpacing: hi/150,),
                  primary: false,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot dede = snapshot.data!.docs[index];
                    return Container(
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Container(
                              height: hi/7,
                              padding: EdgeInsets.only(
                                  top: 7, left: 10, right: 10, bottom: 2),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.network(
                                dede['url'],
                              ),
                            ),
                            www(
                              uidItem: dede['uid'],price: dede['priceOfItem'],Name: dede['nameOfItem'],

                            ),
                          ],
                        ));
                  },
                  shrinkWrap: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class www extends StatefulWidget {

  String uidItem;
  String price;
  String Name;

  www({super.key, required this.uidItem,required this.Name,required this.price, });

  @override
  State<www> createState() => _wwwState();
}

class _wwwState extends State<www> {
  int number = 0;
  final uuid =Uuid().v1();

  addItem2(String uid) {
    try {
      number++;
      if (number == 1) {
        FirebaseFirestore.instance.collection('the-chosen').doc(uid).set({
          'uidUser': FirebaseAuth.instance.currentUser!.uid,
          'uidItem': widget.uidItem,
          'uidOfDoc':uid,
          'number': number
        });
      }
      if (number > 1) {
        FirebaseFirestore.instance
            .collection('the-chosen')
            .doc(uid)
            .set({
          'uidUser': FirebaseAuth.instance.currentUser!.uid,
          'uidItem': widget.uidItem,
          'uidOfDoc':uid,
          'number': number
        });
      }

      setState(() {});
    } catch (e) {
      print('111111111111122222221111111111111111');
      print(e);
      print('111111111111122222221111111111111111');
    }
  }

  removeItem(String uid) {
    try {
      if (number == 1) {
        FirebaseFirestore.instance
            .collection('the-chosen')
            .doc(uid)
            .delete();
      }
      if (number > 0) {
        number--;
        FirebaseFirestore.instance
            .collection('the-chosen')
            .doc(uid)
            .update({
          'uidUser': FirebaseAuth.instance.currentUser!.uid,
          'uidItem': widget.uidItem,
          'uidOfDoc':uid,
          'number': number
        });
      }

      setState(() {});
    } catch (e) {
      print('111111111111122222221111111111111111');
      print(e);
      print('111111111111122222221111111111111111');
    }
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.black12),
          child: Column(
            children: [
              Center(child: Text('${ widget.Name}',style: TextStyle(fontSize: wi/35),)),
              SizedBox(
                height: hi/45,
                child: Divider(),
              ),
              Text(
                '${ widget.price}',
                style: TextStyle(fontSize: wi/27),
              ),
              SizedBox(
                  height:  hi/45,
                  child: Divider(
                    height: 5,
                  )),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            addItem2(uuid);
                          },
                          child: Container(

                              width: wi/15,
                              height: hi/25,
                              color: Colors.transparent,
                              child: Icon(
                                Icons.add,
                                size: wi/15,
                              ))),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${number}',
                        style: TextStyle(fontSize: wi/23),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        child: Container(
                            width: wi/15,
                            height: hi/25,
                            color: Colors.transparent,
                            child: Icon(
                              Icons.remove,
                              size: wi/15,
                            )),
                        onTap: () {
                          removeItem(uuid);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
