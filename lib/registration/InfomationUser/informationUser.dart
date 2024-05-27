

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oscar/widget/TextFormFiled.dart';

import '../phoneNamber/codePhoneNumber.dart';

class InformationUser extends StatefulWidget {
  bool passwordAndEmail;
  String email;
  String password;
   InformationUser({super.key,required this.email,required this.password,required this.passwordAndEmail});

  @override
  State<InformationUser> createState() => _InformationUserState();
}

class _InformationUserState extends State<InformationUser> {
  TextEditingController phoneN = TextEditingController();
  TextEditingController Name = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Uint8List? imagesView2;

  String intrNumber ='+964';

  tackPhoto(ImageSource source)async{
    final ImagePicker imagePicker =ImagePicker();

    final XFile? image= await imagePicker.pickImage(source: source);

    if(image !=null){
      return image.readAsBytes();
    }
  }

  tackCamera()async{
    Uint8List img =await tackPhoto(ImageSource.camera);
    if(img !=null){
      setState(() {
        imagesView2 =img;
      });
    }
  }
  tackGallery()async {
    Uint8List img =await tackPhoto(ImageSource.gallery);
    if(img !=null){
      setState(() {
        imagesView2= img ;
      });

    }

  }

  phoneNumberError(){
    return showDialog(context: context, builder: (context)=>AlertDialog(
      actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.close))
      ],
      title: Text(' خطاء في رقم الهاتف'),
      content: Text('الرجاء التاكد من رقم الهاتف'),
    ));
  }

 Future<void>? NextPage()async{
    try{
      if(globalKey.currentState!.validate()){
        final CorrctPhoneNuber = intrNumber + phoneN.text;
        if(imagesView2 !=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>codePhone(
            phneNumber: CorrctPhoneNuber,
            imageUser: imagesView2!,
            Name:Name.text ,
            Email: widget.email,
            password: widget.password,
            pssworAndEmail: widget.passwordAndEmail,
          )));

        }else{
          return showDialog<void>(barrierDismissible: true,context: context, builder: (BuildContext context){
            return AlertDialog(
              actions: [
                IconButton(onPressed: (){

                  Navigator.pop(context,true);

                }, icon: Icon(Icons.close))
              ],
              title: Text('قم باختيار الصورة '),
              content: Text('لم تقم بآختيار صورة '),
            );});

        }
    }


    }catch(e){}
   return null;


  }






  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body:Form(
        key: globalKey,
        child: Stack(
          children:[
            Image.asset('asset/image/zzz.png',
        width: wi,
            height: hi,
            fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: SafeArea(child: Column(children: [
                  SizedBox(height: hi/13,),
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(context: context, builder: (BuildContext context){
                        return Container(width: wi,
                          height: hi/4,
                          child: Column(
                            children: [
                              ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text('كامرة'),
                                  onTap: (){tackCamera();}
                              ),
                              Divider(),
                              ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text('المحفوظة'),
                                  onTap: (){tackGallery();
                
                                  }
                              )
                            ],
                          ),
                        );
                      });
                
                    },
                    child: Container(
                      width: wi/2.75,height: hi/5.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          image: imagesView2 == null ? DecorationImage(image: AssetImage('asset/image/qqq.png',))
                              :DecorationImage(image: MemoryImage(imagesView2!),fit: BoxFit.cover)
                
                      ),
                      child: Stack(
                        children: [
                
                
                          Positioned(child: Icon(Icons.camera_alt,color: Colors.indigoAccent,),
                            right: 0,bottom: 0,)
                        ],
                
                      ),
                    ),
                  ),
                  SizedBox(height: hi/30,),
                
                  TextFormFiled2(
                    fontSize: wi/22,
                    validator: (val){
                      if(val!.isEmpty){
                        return 'الرجاء اكتب الاسم';
                      }else if(val.length < 5){
                        return 'الاسم قصير';
                      }
                      return null;
                    },
                    controller: Name,
                    borderRadius: 15,
                    label: 'الآسم',
                    obscure: false,
                    wight: wi,
                    height: hi/12),
                
                
                  SizedBox(height: hi/50,),
                
                  Container(
                   alignment: Alignment.center,
                    width: wi,
                    height: hi/12,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black87)
                    ),
                
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                
                
                          ),
                
                          width: wi/6,
                          height: hi/20,
                          child: Text(
                            intrNumber,style: TextStyle(fontWeight: FontWeight.w800,fontSize: wi/22),
                          ),
                        ),
                
                        Expanded(
                          child: TextFormField(
                
                            keyboardType: TextInputType.number,
                            obscureText: false,
                
                
                
                
                            controller: phoneN ,
                            validator: (val){
                              if(val!.length > 10 ){
                                return phoneNumberError();
                              }else if(val.length <10 ){
                                return phoneNumberError();
                              }
                              return null;
                            },
                
                            decoration: InputDecoration(
                
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:  BorderSide.none
                                ),
                
                
                
                
                                hintText: 'رقم الهاتف',
                
                
                                hintStyle:  TextStyle(fontSize: wi/22,color: Colors.black87,fontWeight: FontWeight.w800 )
                            ),
                
                
                          ),
                        ),
                      ],
                    ),
                
                  ),
                  SizedBox(height: hi/3.5,),
                  GestureDetector(
                    onTap: ()async{
                      NextPage();
                
                
                    },
                    child: Container(
                      width: wi,
                      height: hi/12,
                      child: Center(
                        child: Text('التالي',style: TextStyle(fontSize: wi/22),),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black)
                      ),
                    ),
                  )
                    ],
                  )
                
                          ),
              )),

            ]
        ),
      )
    );
  }
}
