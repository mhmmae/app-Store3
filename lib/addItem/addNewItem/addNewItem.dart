

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'informationOFItem.dart';

class viewImage extends StatefulWidget {
   viewImage({super.key,required this.uint8list,required this.TypeItem,});
     //
  Uint8List uint8list;
   String TypeItem;

  @override
  State<viewImage> createState() => _viewImageState();
}

class _viewImageState extends State<viewImage> {


  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(

        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: MemoryImage(widget.uint8list,)
              )
            ),
          ),
          Positioned(bottom: hi/12,right: wi/12,
              child:
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>InformationOfItem(
                    TypeItem: widget.TypeItem,
                    uint8list: widget.uint8list,
                  )));
                },
                child: Container(height: hi/12,width: wi/5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent,width: 2),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.send,size: 45,color: Colors.blueAccent,)),
              )

          ),
          Positioned(bottom: hi/12,left: wi/12,
              child:
              Container(height:hi/12,width: wi/5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red,width: 2),
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.keyboard_backspace_sharp,size: 45,color: Colors.red,))

          ),
        ],
      ),
    );
  }
}
