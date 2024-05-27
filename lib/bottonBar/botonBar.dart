
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../HomePage/home/home.dart';
import '../addItem/addItem.dart';
import '../chat/Chat.dart';

class bottonBar extends StatefulWidget {
  const bottonBar({super.key});

  @override
  State<bottonBar> createState() => _bottonBarState();
}

class _bottonBarState extends State<bottonBar> {
  
  List<Widget> ListOfPage = <Widget>[


    const home(),
    const addItem(),
  ];
  
  int theIndex= 0;
  
  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(


        bottomNavigationBar:

        GNav(selectedIndex:theIndex,
        mainAxisAlignment:    MainAxisAlignment.spaceBetween,
        padding: EdgeInsets.all(wi/60),
        iconSize: 30,
        textSize: 33,
        activeColor: Colors.blueAccent,



        onTabChange:(val){
                setState(() {
                  theIndex = val;
                });
        },
        tabs: [GButton(icon: Icons.confirmation_number_sharp,text: 'home',),
                GButton(icon: Icons.add_a_photo_outlined,text: 'jyy',),
                GButton(icon: Icons.add,text: 'home',),
          GButton(icon: Icons.confirmation_number_sharp,text: 'home',),
          GButton(icon: Icons.add_a_photo_outlined,text: 'jyy',),
          GButton(icon: Icons.add,text: 'home',)]),



      body: ListOfPage.elementAt(theIndex),

    );
  }
}
