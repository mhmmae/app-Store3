


import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../bottonBar/botonBar.dart';
import '../../widget/TextFormFiled.dart';
import '../addItem.dart';

class InformationOfItem extends StatefulWidget {
  Uint8List uint8list;

   InformationOfItem({super.key,required this.uint8list,required this.TypeItem,});
   String TypeItem;


  @override
  State<InformationOfItem> createState() => _InformationOfItemState();
}

class _InformationOfItemState extends State<InformationOfItem> {
  TextEditingController nameOfItem = TextEditingController();
  TextEditingController priceOfItem = TextEditingController();
  TextEditingController descriptionOfItem = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool loading = false;





  Future<void> saveData()async{

    try{
      Reference storge =  firebaseStorage.ref('oscare').child(Uuid().v1());
      UploadTask uploadTask =storge.putData(widget.uint8list);
      TaskSnapshot taskSnapshot =await uploadTask;
      String url =await taskSnapshot.ref.getDownloadURL();


      final uid2 =  Uuid().v1();
      await FirebaseFirestore.instance.collection(widget.TypeItem).doc(uid2).set({
        'nameOfItem':nameOfItem.text,
        'priceOfItem':priceOfItem.text,
        'descriptionOfItem':descriptionOfItem.text,
        'url':url,
        'appName':'oscare',
        'uid':uid2,





      }).then((value)=> Navigator.push(context, MaterialPageRoute(builder: (context)=> bottonBar())));

    }catch(e){print('111111111111111111111111111111111');
      print(e);
    }





  }


  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading?Center(child: CircularProgressIndicator(),):Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
               widget.TypeItem =='Item'? SafeArea(
                 child: Column(
                    children: [
                 
                      SizedBox(height: hi/10,),
                      TextFormFiled2(controller: nameOfItem,
                          borderRadius: 15,
                          fontSize: wi/22,
                          label: 'اسم المنتج',
                          obscure: false,
                          wight: double.infinity,
                          height: hi/15,
                        validator: (val){
                          if(val == null){
                            return ' اسم المنتج اكتب';
                          }
                        },
                      ),
                      SizedBox(height: hi/40,),
                      TextFormFiled2(controller: descriptionOfItem,
                          borderRadius: 15,
                          fontSize: wi/22,
                          label: 'وصف للمنتج',
                          obscure: false,
                          wight: double.infinity,
                          height: hi/15,
                        validator: (val){
                        if(val == null){
                          return 'اكتب وصف للمنتج';
                        }
                        },
                      ),
                      SizedBox(height: hi/40,),
                      TextFormFiled2(controller: priceOfItem,textInputType2: TextInputType.number,
                          borderRadius: 15,
                          fontSize: wi/22,

                          label: 'سعر المنتج',
                          obscure: false,
                          wight: double.infinity,
                          height: hi/15,
                        validator: (val){
                          if(val == null){
                            return ' اكتب سعر المنتج';
                          }
                        },
                      ),
                 
                    ],
                  ),
               ):       Column(
                 children: [
          
                   SizedBox(height: hi/10,),
                   TextFormFiled2(controller: nameOfItem,
                     borderRadius: 15,
                     fontSize: wi/22,
                     label: 'اسم المنتج',
                     obscure: false,
                     wight: double.infinity,
                     height: hi/15,
                     validator: (val){
                       if(val == null){
                         return ' اكتب اسم المنتج';
                       }
                     },
                   ),
                   SizedBox(height: hi/40,),
                   TextFormFiled2(controller: descriptionOfItem,
                     borderRadius: 15,
                     fontSize: wi/22,
                     label: 'وصف للمنتج',
                     obscure: false,
                     wight: double.infinity,
                     height: hi/15,
                     validator: (val){
                       if(val == null){
                         return 'اكتب وصف للمنتج';
                       }
                     },
                   ),
                   SizedBox(height: hi/40,),
                   TextFormFiled2(controller: priceOfItem,
                     textInputType2: TextInputType.number,
                     borderRadius: 15,
                     fontSize: wi/22,
                     label: 'سعر المنتج القديم',
                     obscure: false,
                     wight: double.infinity,
                     height: hi/15,
                     validator: (val){
                       if(val == null){
                         return 'اكتب سعر المنتج';
                       }
                     },
                   ),
                   SizedBox(height: hi/40,),
                   TextFormFiled2(controller: descriptionOfItem,
                     borderRadius: 15,
                     fontSize: wi/22,
                     textInputType2: TextInputType.number,
                     label: 'سعر المنتج الجديد',
                     obscure: false,
                     wight: double.infinity,
                     height: hi/15,
                     validator: (val){
                       if(val == null){
                         return 'اكتب سعر للمنتج';
                       }
                     },
                   ),
                   SizedBox(height: hi/40,),
                   TextFormFiled2(controller: descriptionOfItem,
                     borderRadius: 15,
                     fontSize: wi/22,
                     textInputType2: TextInputType.number,
                     label: 'نسبة التخفيض  ',
                     obscure: false,
                     wight: double.infinity,
                     height: hi/15,
                     validator: (val){
                       if(val == null){
                         return 'اكتب نسبة التخفيض ';
                       }
                     },
                   ),
                   SizedBox(height: hi/3.6,),
          
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child: Row(
                       mainAxisAlignment:   MainAxisAlignment.spaceBetween,
                       children: [
                         GestureDetector(
                             onTap: (){saveData();},
                             child: Container(
                                 height:hi/12,width: wi/5,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.red,width: 2),
                                     color: Colors.white70,
                                     borderRadius: BorderRadius.circular(10)),
                                 child: Icon(
                                   Icons.keyboard_backspace_sharp,
                                   size: 45,
                                   color: Colors.red,
                                 ))
                         ),
          
          
          
          
                         GestureDetector(
                           onTap: (){saveData();},
                           child: Container(
                               height:hi/12,width: wi/5,
                               decoration: BoxDecoration(
                                   color: Colors.white70,
                                   border: Border.all(color: Colors.blueAccent,width: 2),
                                   borderRadius: BorderRadius.circular(10)),
                               child: Icon(
                                 Icons.send,
                                 size: 45,
                                 color: Colors.blueAccent,
                               )),
                         )
          
                       ],
                     ),
                   ),
                 ],
               ),
          
          
              ],
            ),
          ),
        ),
      ),


    );
  }
}
