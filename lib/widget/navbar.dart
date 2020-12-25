import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_kareem/colors.dart';
import 'package:quran_kareem/screens/home_screen.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarItem(Icons.arrow_back_ios,(){
            Navigator.pop(context);
          }),
          Text("Playing Now",style: TextStyle(fontSize: 16,color: darkPrimaryColor,fontWeight: FontWeight.w300),),
          NavBarItem(Icons.list,(){
            Navigator.push(context, MaterialPageRoute(builder: (c){return MyHomeScreen();}));
          }),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  IconData icon;
  Function param1;
  NavBarItem(this.icon, this.param1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: param1,
      child: Container(

        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: darkPrimaryColor.withOpacity(0.5),
            offset: Offset(5, 10),
            spreadRadius: 3,
            blurRadius: 10,
          )
        ], color: primaryColor, borderRadius: BorderRadius.circular(10.0)),
        child: Icon(

          icon,
          color: darkPrimaryColor,
        ),
      ),
    );
  }
}
