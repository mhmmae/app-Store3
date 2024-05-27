


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:oscar/HomePage/home/home.dart';
import 'package:oscar/bottonBar/botonBar.dart';
import 'package:uuid/uuid.dart';

import 'TextFomeFildeCodePhone.dart';

class codePhone extends StatefulWidget {
  String phneNumber;
  Uint8List imageUser;
  String Name;
  String Email;
  String password;
  bool pssworAndEmail;

   codePhone({super.key, required this.phneNumber,required this.imageUser,
     required this.Name,required this.Email,required this.password,required this.pssworAndEmail});

  @override
  State<codePhone> createState() => _codePhoneState();
}

class _codePhoneState extends State<codePhone> {

  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  TextEditingController c5 = TextEditingController();
  TextEditingController c6 = TextEditingController();
  bool correct1 =true;
  int connter =100;
  late Timer timer1;

  String? verifidCodeSent;

  bool isLoding =false;


  void startTimer(){
   timer1= Timer.periodic(const Duration(seconds: 1), (timer) {
     setState(() {
       if(connter>0){
         connter--;
       }else{
         timer.cancel();
       }
     });
    });
  }

  void phoneAuthCode() async{

    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phneNumber,
        timeout: const Duration(seconds: 90),
        verificationCompleted: (PhoneAuthCredential credential) {
          print('111111111111111111111111111111111');
          print('111111111111111111111111111111111');
          print('111111111111111111111111111111111');

        },
        verificationFailed: (FirebaseAuthException e) {


          print('22222222222222222222222222222222222');
          print(e);
          print('22222222222222222222222222222222222');
          print('22222222222222222222222222222222222');



        },
        codeSent: (String verificationId, int? resendToken) async{

           verifidCodeSent = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verifidCodeSent = verificationId;
        },
      );
    }catch(e){
      setState(() {

        correct1 =false;
      });
    }

  }

  void sentCode()async{
    try{
      setState(() {
        isLoding=true;
      });
      String smsCode = c1.text + c2.text + c3.text + c4.text + c5.text + c6.text;
      print(smsCode);

      PhoneAuthCredential credential = PhoneAuthProvider
          .credential(verificationId: verifidCodeSent!, smsCode: smsCode);
      if(smsCode == credential.smsCode){
        print('999999999999999999999999999999999');
        print('3333333333333333333333333333333333');
        // await FirebaseAuth.instance.signInWithCredential(credential).then((value)async{

          if(widget.pssworAndEmail =true){
            print('1010101010101010101010010101001010101010101010');
            print('1010101010101010101010010101001010101010101010');
            print('1010101010101010101010010101001010101010101010');


            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: widget.Email, password: widget.password).then((value) async{
              Reference stprge=   FirebaseStorage.instance.ref('oscar').child(const Uuid().v1());
              UploadTask upload =  stprge.putData(widget.imageUser);
              TaskSnapshot task = await upload;
              String url22 = await task.ref.getDownloadURL();

              await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).set({
                'url':url22 ,
                'phneNumber': widget.phneNumber ,
                'name' : widget.Name ,
                'password': widget.password ,
                'email' : widget.Email ,
                'uid':FirebaseAuth.instance.currentUser!.uid




              }).then((value)async {


                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>const bottonBar()));


              });

            });



          }else{
            print('//////////////////////q//////q///////q////q///q/////q///');


            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const bottonBar()));


          }





        // });
      }



    }on FirebaseAuthException catch (e){
      if(e.code == 'invalid-verification-code'){
        setState(() {
          correct1 =false;
          isLoding =false;
        });
      }
    }
    catch(e){
      print('3333333333333333333333333333333333');
      print(e);

      print('3333333333333333333333333333333333');

    }
  }





  @override
  void dispose() {
    // TODO: implement dispose
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    c5.dispose();
    c6.dispose();
    timer1.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
     phoneAuthCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: hi/4.5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly
                ,children: [
                TextFomeFildeCodePhone(first: true,last: false,codePhone: c1,correct: correct1,),
                TextFomeFildeCodePhone(first: false,last: false,codePhone: c2,correct: correct1,),
                TextFomeFildeCodePhone(first: false,last: false,codePhone: c3,correct: correct1,),
                TextFomeFildeCodePhone(first: false,last: false,codePhone: c4,correct: correct1,),
                TextFomeFildeCodePhone(first: false,last: false,codePhone: c5,correct: correct1,),
                TextFomeFildeCodePhone(first: false,last: true,codePhone: c6,correct: correct1,sendcode: (){
                  print('000000000000000000000000000000');
        
        
                  sentCode();
                },),
        
        
              ],),
            ),
            SizedBox(height: hi/10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
        
                  GestureDetector(
                    onTap: (){
                      phoneAuthCode();
        
                    },
                    child: Container(padding: EdgeInsets.symmetric(horizontal: 8),decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12
                    ),child: Text('اعد ارسال الكود',style: TextStyle(color: Colors.blueAccent,fontSize: wi/19,fontWeight: FontWeight.w900))),
                  ),
                  Text('$connter',style: TextStyle(color: Colors.black,fontSize: wi/15),),
        
                ],
              ),
            ),
            Center(child: isLoding?CircularProgressIndicator():null,),
        
        
        
        
          ],
        ),
      ),
    );
  }
}
