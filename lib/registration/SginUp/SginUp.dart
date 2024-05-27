
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../HomePage/home/home.dart';
import '../../bottonBar/botonBar.dart';
import '../../chat/Chat.dart';
import '../../widget/TextFormFiled.dart';
import '../InfomationUser/informationUser.dart';
import '../signin/signinPage.dart';

class SinUp extends StatefulWidget {
  const SinUp({super.key});

  @override
  State<SinUp> createState() => _SinUpState();
}

class _SinUpState extends State<SinUp> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isLoding =false;




  Future<void> signInWithGoogle() async {
    try{
      setState(() {
        isLoding =true;
      });
      List<String> scopes = <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ];
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            setState(() {
              isLoding =false;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=>bottonBar()));
            print(documentSnapshot.data());

          }else{
            setState(() {
              isLoding =false;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=>InformationUser(
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              password: 'NO PASSWORD',
              passwordAndEmail: false,
            )));
          }
        });

      });

    }catch(e){
      setState(() {
        isLoding =false;
      });

    }

  }

  Future<void> SignUp() async {
    try {
      setState(() {
        isLoding =true;
      });
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      ).then((value)async{
       await FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage(isFirstTime: true,)));
         setState(() {
           isLoding =false;
         });
       });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return showDialog(context: context, builder: (context)=>AlertDialog(
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              setState(() {
                isLoding =false;
              });
            }, icon: Icon(Icons.close))
          ],
          title: Text('الباسورد ضعيف'),
          content: Text('يجب ان يكون اكثر من 6'),
        ));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return showDialog(context: context, builder: (context)=>AlertDialog(
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).pop();
              setState(() {
                isLoding =false;
              });
            }, icon: Icon(Icons.close))
          ],
          title: Text('الايمل موجود بالفعل'),
          content: Text('قم بتسجيل الدخول'),
        ));
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(FirebaseAuth.instance.currentUser!.displayName);

      print(e);
      print('2222222222222222222222222222');

    }

  }



  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return  Scaffold(
      extendBodyBehindAppBar: true,

      body: Form(
        key: globalKey,
        child: Stack(children: [
          Image.asset(
            'asset/image/zzz.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          isLoding ? Center(child: CircularProgressIndicator())
              :  SingleChildScrollView(
            child: SafeArea(
              child:   Column(
                children: [
                  SizedBox(height: hi/15,),
                  Text(
                    'التسجيل\n',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: wi/17,
                        fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
            
            
            
                      TextFormFiled2(
                        fontSize: wi/22,
                          wight: wi,
                          height: hi/12,
                        borderRadius: 20,
                          obscure: false,
            
                          controller: email,
                          validator: (val) {
                            if (val!.isEmpty  ) {
                              return 'رجاء آكتب الآيميل';
                            }
                            if (!RegExp(
                                r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                .hasMatch(val)) {
                              return 'الرجاء اكتب الايميل بشكل صحيح';
                            }
                            return null;
                          },
                          label: 'Email'),
                      const SizedBox(
                        height: 7,
                      ),
            
                      TextFormFiled2(
                        fontSize: wi/22,
                          wight: double.infinity,
                          height: hi/12,
                          borderRadius: 20,
            
                          obscure: true,
                          controller: password,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'رجاء آكتب الباسود';
                            }if(val.length <= 6){
                              return 'اجعل الباسورد اقوى';
                            }
                            return null;
                          },
                          label: 'Password'),
            
                    ]),
                  ),
                  SizedBox(height: hi/5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: ()async{
                            if (globalKey.currentState!.validate()) {
                              try {
                                SignUp();
            
                                // Reference stprge=   FirebaseStorage.instance.ref('oscare').child(Uuid().v1());
                                // UploadTask upload =  stprge.putData(imagesView2!);
                                // TaskSnapshot task = await upload;
                                // String url22 = await task.ref.getDownloadURL();
                                // await FirebaseFirestore.instance.collection(
                                //     'users2')
                                //     .doc(
                                //     FirebaseAuth.instance.currentUser!.uid)
                                //     .set({
                                //   'email': email.text,
                                //   'password': password.text,
                                //   'uid': FirebaseAuth.instance.currentUser!.uid,
                                //   'name': name.text,
                                //
                                // })
                                //     .then((value) =>
                                //     Navigator.push(context, MaterialPageRoute(
                                //         builder: (context) =>
                                //             chat()))
                                //
                                // );
            
                                // }
                              } catch (e) {
                                print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
                                print(e);
                                print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: wi,
                            height: hi/12,
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(16)),
                            child:  Text('التسجيل',style: TextStyle(fontSize: wi/19,fontWeight: FontWeight.w600),),
                          ),
                        ),
                        SizedBox(height: hi/40,),
            
            
                         Row(
                          children: [
                           const Expanded(child: Divider()),
                            const  SizedBox(width: 6,),
                            Text('او التسحيل مع',style: TextStyle(color: Colors.white,fontSize: wi/25,fontWeight: FontWeight.w600),),
                            const  SizedBox(width: 6,),
            
                            const  Expanded(child: Divider())
                          ],
                        ),
                        SizedBox(height: hi/40,),
            
                        Container(
                          width: wi,
                          height: hi/12,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: (){
                              signInWithGoogle();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: wi/10,height: hi/22,
                                  child: Image.asset('asset/image/ggg.png'),
                                ),
                                Text('التسجيل مع كوكل ',style: TextStyle(fontSize: wi/27),),
                                SizedBox(width:wi/30,)
                              ],
                            ),
                          ),
                        )
            
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
