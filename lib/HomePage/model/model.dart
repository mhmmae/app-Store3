
import 'package:flutter/foundation.dart' show immutable;

@immutable class homeModel{
  final String photo;
  final String title;
  final String price;

  homeModel({required this.photo,required this.price,required this.title});

  Map<String,dynamic> toMap(){
    return <String, dynamic >{
      'photo':photo,
      'title':title,
      'price':price
    };
  }
  factory homeModel.fromMap(Map<String,dynamic> map){
    return homeModel(photo: map['photo']?? ''
        , price: map['price'] ?? ''
        , title: map['title'] ?? '');
  }
}