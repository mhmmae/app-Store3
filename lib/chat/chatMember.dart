

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/TextFormFiled.dart';
import 'Chat.dart';

class member extends StatefulWidget {
  const member({super.key});

  @override
  State<member> createState() => _memberState();
}

class _memberState extends State<member> {

  TextEditingController searchMember=TextEditingController();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Chat')
      .doc(FirebaseAuth.instance.currentUser!.uid).collection('chat').orderBy('time').snapshots();

  Stream<DocumentSnapshot> memberUid(String memberUid) {
    return  FirebaseFirestore.instance
        .collection('user')
        .doc(memberUid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: hi/15,),
                    Row(
                      children: [TextFormFiled2(
                        fontSize: wi/22,
                            controller: searchMember,
                            borderRadius: 15,
                            label: 'Search',
                            obscure: false,
                            wight: wi/1.3,
                            height: hi/17)
                      ],
                    ),
        
                  ],
        
                ),
              ),
            ) ,
            Container(

              width: wi,
              height: hi,

              child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
        
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
        
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> chat1 = document.data()! as Map<String, dynamic>;
                      return  StreamBuilder<DocumentSnapshot>(
                        stream: memberUid(chat1['sender']),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }
                          Map<String, dynamic> user = snapshot.data!.data() as Map<String, dynamic>;
                          if (snapshot.connectionState == ConnectionState.done) {

                            return Text("Full Name: ${user['email']} ${user['name']}");
                          }

                          return ListView(
                            shrinkWrap: true,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>chat(uid: chat1['sender'],)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: Container(decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                     ,color: Colors.black12,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      width: wi/7,
                                      height: hi/15,
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.black,width: 1.5),
                                        image: DecorationImage(
                                          image: NetworkImage(user['url']),
                                          fit: BoxFit.cover
                                        )


                                      ),

                                    ),
                                    title: Text(user['name']),

                                    subtitle: Text(chat1['message']),
                                  )),
                                ),
                              ),
                              SizedBox(height: hi/130,)
                            ],
                          );
                        },
                      );
                    }).toList(),
                  );
        
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
