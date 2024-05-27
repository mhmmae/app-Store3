


import 'package:flutter/material.dart';

class TextFormFiled2 extends StatelessWidget {
  const TextFormFiled2({super.key, required this.controller,required this.borderRadius,
    this.validator, required this.label, required this.obscure, required this.wight, required this.height,
  this.textInputType2, required this.fontSize}) ;


 final TextEditingController  controller;
 final String? Function(String?)? validator;
 final String label;
 final double borderRadius;
 final bool obscure;
 final double wight;
 final double height;
 final TextInputType? textInputType2;
 final double fontSize;





  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: wight,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 5),

      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.black87)
      ),

        child: TextFormField(
          keyboardType: textInputType2,
          obscureText: obscure,




          controller: controller ,
          validator: validator,

          decoration: InputDecoration(

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide:  BorderSide.none
            ),




            hintText: label,


            hintStyle:  TextStyle(fontSize: fontSize,color: Colors.black87,fontWeight: FontWeight.bold )
          ),


        ),

    );
  }
}
