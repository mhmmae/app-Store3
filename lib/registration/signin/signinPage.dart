
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oscar/HomePage/home/home.dart';

import '../../bottonBar/botonBar.dart';
import '../../widget/TextFormFiled.dart';
import '../InfomationUser/informationUser.dart';
import '../SginUp/SginUp.dart';

class SignInPage extends StatefulWidget {
  bool? isFirstTime =false ;
   SignInPage({super.key,required this.isFirstTime});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController  Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  bool? remaberMe =true ;
  bool isLosing =false;






  Future<void> signInWithGoogle() async {
    try{
      setState(() {
        isLosing =true;
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
              isLosing =false;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=>bottonBar()));
            print(documentSnapshot.data());

          }else{
            setState(() {
              isLosing =false;
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
        isLosing =false;
      });

    }

  }


   Intention() async {

    try{
      Future.delayed(Duration(seconds: 2), () {
        if (widget.isFirstTime == true ) {
          return showDialog<void>(barrierDismissible: true,context: context, builder: (BuildContext context){
            return AlertDialog(
              actions: [
                IconButton(onPressed: (){
                  setState(() {
                    widget.isFirstTime =false;
                  });
                  Navigator.pop(context,true);

                }, icon: Icon(Icons.close))
              ],
              title: Text('قم بالتحقق من الآيميل '),
              content: Text('آذهب الى البريد الوارد'),
            );});
        }else{ return null;}

      });



    }catch(e){
      print('777777777777777777777777777');
      print(e);
      print('777777777777777777777777777');

    }
  }

  Future<void> signIn1()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email.text,
        password: Password.text
    ).then((value) {                   Navigator.push(context, MaterialPageRoute(builder: (context)=>bottonBar()));
    });

  }






  Future<void> signIn()async{
     try{



       if(globalKey.currentState!.validate()){
         setState(() {
           isLosing =true;
         });

            await FirebaseAuth.instance.signInWithEmailAndPassword(
               email: Email.text,
               password: Password.text
           ).then((value){
             if(value.user!.emailVerified) {
               FirebaseFirestore.instance
                   .collection('user')
                   .doc(FirebaseAuth.instance.currentUser!.uid)
                   .get()
                   .then((DocumentSnapshot documentSnapshot) {
                 if (documentSnapshot.exists) {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>bottonBar()));
                   print(documentSnapshot.data());

                 }else{
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>InformationUser(
                     email: Email.text,
                     password: Password.text,
                     passwordAndEmail: true,
                   )));

                 }
               });
             }

             else{
               setState(() {
                 isLosing=false;
               });
               print('111111111111111111emailVerified');
               return showDialog<void>(barrierDismissible: true,context: context, builder: (BuildContext context){
                 return AlertDialog(
                   actions: [
                     IconButton(onPressed: (){
                       setState(() {
                         widget.isFirstTime =false;
                       });
                       Navigator.pop(context,true);

                     }, icon: Icon(Icons.close))
                   ],
                   title: Text('قم بالتحقق من الآيميل '),
                   content: Text('آذهب الى البريد الوارد'),
                 );});

             }

           });

       }

     }on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         setState(() {
           isLosing=false;
         });
         print('111111111111111111user-not-found');
         return showDialog<void>(barrierDismissible: true,context: context, builder: (BuildContext context){
           return AlertDialog(
             actions: [
               IconButton(onPressed: (){
                 setState(() {
                   widget.isFirstTime =false;
                 });
                 Navigator.pop(context,true);

               }, icon: Icon(Icons.close))
             ],
             title: Text('الايميل غير صحيح'),
             content: Text('هذا الايميل غير موجود'),
           );});
       } else if (e.code == 'wrong-password') {
         setState(() {
           isLosing=false;
         });
         print('111111111111111111user-not-found');
         return showDialog<void>(barrierDismissible: true,context: context, builder: (BuildContext context){
           return AlertDialog(
             actions: [
               IconButton(onPressed: (){
                 setState(() {
                   widget.isFirstTime =false;
                 });
                 Navigator.pop(context,true);

               }, icon: Icon(Icons.close))
             ],
             title: Text('الايميل او الرمز السري خطاء'),
             content: Text('حاول مرة اخرى'),
           );});

       }
     }catch(e){
       print('2222222222222222222222222222');
       print(e);
       print('2222222222222222222222222222');

     }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
       
        body:

           Stack(children: [
            Image.asset(
              'asset/image/zzz.png',
              width: wi,
              height: hi,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      SizedBox(height: hi/15,),
                       Text(
                         'تسجيل الدخول\n',
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: wi/17,
                             fontWeight: FontWeight.w300),
                       ),
              
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: Column(
                          children: [
                            TextFormFiled2(
                              fontSize: wi/22,
                              wight: wi,
                              height: hi/12,
                              borderRadius: 15,
              
                              obscure: false,
              
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'اكتب ايميل المستخدم';
                                }
                                return null;
                              },
                              label: 'Email',
                              controller: Email,
                            ),
                             SizedBox(
                              height: hi/70,
                            ),
                            TextFormFiled2(
                              fontSize: wi/22,
                              wight: wi,
                              height: hi/12,
                              borderRadius: 15,
              
                              obscure: true,
              
                              validator: (val) {
              
                                if (val!.isEmpty) {
                                  return 'اكتب الباسورد';
                                }
                                return null;
                              },
                              label: 'Password',
                              controller: Password,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(value: remaberMe, onChanged: ( val){
                                      setState(() {
                                        remaberMe = val;
                                      });
                                    },activeColor: Colors.blue,
                                    ),
                                     Text('Remember Me',style: TextStyle(color: Colors.white,fontSize: wi/40,fontWeight: FontWeight.w700),)
                                  ],
                                ),
                                 Text('Forget Passowrd?',style: TextStyle(color: Colors.blue,fontSize: wi/35,fontWeight: FontWeight.w900),)
              
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: hi/12,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: GestureDetector(
                          onTap: (){
                            try{signIn();}catch(e){
                              print(e);
                            }
              
              
                          },
              
                          child: isLosing?Center(child: CircularProgressIndicator()) : Container(
                            width: wi,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
              
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white60),
                            child:  Text(
                              'تسجيل الدخول',
                              style: TextStyle(fontSize: wi/19,fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: hi/20,
                      ),
              
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:  Row(
                          children: [
                            Expanded(child: Divider()),
                            SizedBox(width: wi/60,),
                            Text('او التسحيل مع',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),),
                            SizedBox(width: wi/60,),
              
                            Expanded(child: Divider())
                          ],
                        ),
                      ),
                      SizedBox(height: hi/30,),
              
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: (){
                            // signInWithGoogle();
                            print('333333333333333');
                            print(FirebaseAuth.instance.currentUser);
              
                          },
                          child: Container(
                            width: wi,
                            height: hi/12,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: wi/10,height: hi/22,
                                  child: Image.asset('asset/image/ggg.png'),
                                ),
                                Text('تسجيل الدخول مع كوكل ',style: TextStyle(fontSize: wi/27),),
                                SizedBox(width: wi/30,)
                              ],
                            ),
                          ),
                        ),
                      )
              
                    ],
                  ),
                ),
              ),
            )
          ]),
        );
  }
}

