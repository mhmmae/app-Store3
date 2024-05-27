

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../widget/TextFormFiled.dart';

class chat extends StatefulWidget {
  String uid;
   chat({super.key,required this.uid});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {



  String userId ='WDzeZoWzwSRFRLxxgGb0tOrrxdA3';







  TextEditingController Maseage= TextEditingController();
  sendMessage2()async{

    try{
      if(Maseage.text.isNotEmpty){
        final uid1 = Uuid().v1();
        await FirebaseFirestore.instance.collection('Chat')
            .doc(FirebaseAuth.instance.currentUser!.uid).collection('chat')
            .doc(widget.uid).collection('messages').doc(uid1).set({
          'sender':FirebaseAuth.instance.currentUser!.uid,
          'resiveID':widget.uid,
          'message':Maseage.text,
          'time':DateTime.now().millisecondsSinceEpoch,
          'uidMassege' : uid1,
          'type':'text'

        }).then((value) => FirebaseFirestore.instance.collection('Chat')
            .doc(FirebaseAuth.instance.currentUser!.uid).collection('chat')
            .doc(widget.uid).set({
          'sender':widget.uid,
          'resiveID':FirebaseAuth.instance.currentUser!.uid,
          'message':Maseage.text,
          'time':DateTime.now().millisecondsSinceEpoch,
          'type':'text',


        }));





        await FirebaseFirestore.instance.collection('Chat')
            .doc(widget.uid).collection('chat')
            .doc(FirebaseAuth.instance.currentUser!.uid).collection('messages').doc(uid1).set({
          'sender':FirebaseAuth.instance.currentUser!.uid,
          'resiveID':widget.uid,
          'message':Maseage.text,
          'time':DateTime.now().millisecondsSinceEpoch,
          'uidMassege' : uid1,
          'type':'text'

        }).then((value) => FirebaseFirestore.instance.collection('Chat')
            .doc(widget.uid).collection('chat')
            .doc(FirebaseAuth.instance.currentUser!.uid).set({
          'sender':FirebaseAuth.instance.currentUser!.uid,
          'resiveID':widget.uid,
          'message':Maseage.text,
          'time':DateTime.now().millisecondsSinceEpoch,
          'type':'text',


        }));

        Maseage.clear();



      }


    }


    catch(e){

      print('111111111111111111111111111111111111');
      print(e);
      print('111111111111111111111111111111111111');

    }
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('111111111111111111111111111111111111');
    print(FirebaseAuth.instance.currentUser!.uid);
    print('111111111111111111111111111111111111');

  }

  @override
  Widget build(BuildContext context) {

    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 1,


        actions: [ Padding(
          padding: const EdgeInsets.only(right: 13),
          child: Container(child: Icon(Icons.call),
            width: wi/10,height: wi/10,
            decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16)
            ),),
        )],
        leadingWidth: wi/3,
        leading:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Row(
            children: [
              GestureDetector(onTap: (){Navigator.pop(context);},child: Icon(Icons.arrow_back)),
              SizedBox(width: wi/30,),
              Text('اوسكار',style: TextStyle(fontSize: wi/22,color: Colors.black,fontWeight: FontWeight.w800),),
            ],
          ),
        ) ,
      ),
      body: Column(
        children: [


             Expanded(
               flex: 5,
               child: Container(
                 width: wi,
                 height: hi/1.6,
                 color: Colors.white,

                 child: StreamBuilder<QuerySnapshot>(
                   stream: FirebaseFirestore.instance.collection('Chat')
                       .doc(FirebaseAuth.instance.currentUser!.uid).collection('chat')
                       .doc(widget.uid).collection('messages').orderBy('time').snapshots(),
                   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                     if (snapshot.hasError) {
                       return Text('Something went wrong');
                     }


                     if (snapshot.connectionState == ConnectionState.waiting) {
                       return Text("Loading");
                     }

                     return ListView(

                       children: snapshot.data!.docs.map((DocumentSnapshot document) {
                         Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                         bool isMe =FirebaseAuth.instance.currentUser!.uid == data['sender'] ;
                         return Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 8),
                           child: Align(
                             alignment: isMe? Alignment.centerRight:Alignment.centerLeft,
                             child: Container(
                               child: Padding(
                                 padding:  isMe ?EdgeInsets.only(left: 80,bottom: 4,top: 4):EdgeInsets.only(right: 80,bottom: 4,top: 4),
                                 child: Container(
                                   decoration: BoxDecoration(

                                     borderRadius: BorderRadius.circular(16),
                                     color: isMe ?Colors.blueAccent:Colors.black12

                                   ),
                                   child:  Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text(data['message'],style: TextStyle(fontSize: 17),),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         );
                       }).toList(),
                     );
                   },
                 ),



                         ),
             ),
          Container(


            width: wi,
            height: hi/15,
            decoration: BoxDecoration(
                color: Colors.white,
            border: Border.all(color: Colors.black),

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  TextFormFiled2(controller: Maseage,
                      borderRadius: 15,
                      fontSize: hi/60,
                      label: 'Massege',
                      obscure: false,
                      wight: wi/1.6,
                      height: hi/19),
                  SizedBox(width: 2.w,),

                  Icon(Icons.add,size: wi/12,),
                  SizedBox(width: 5.w,),

                  GestureDetector(
                    onTap: (){sendMessage2();},
                    child: Container(decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(19),

                    ),
                      child: Center(child: Icon(Icons.send_rounded,color: Colors.white,)),
                    width: hi/18,height: hi/20,),
                  )

                ],
              ),
            ),
          ),

        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),

    );
  }
}
