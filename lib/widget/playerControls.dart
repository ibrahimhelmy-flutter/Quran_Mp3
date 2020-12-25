import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_kareem/model/myAudio.dart';
import 'package:quran_kareem/services/quran_service.dart';

import '../colors.dart';

class PlayerControls extends StatelessWidget {
  Reciter reciter; String snum; List<String> numberList;
  PlayerControls(this.reciter, this.snum, this.numberList);



  @override
  Widget build(BuildContext context) {
    int n=int.parse(snum).toInt();
    return Consumer<MyAudio>(
      builder: (context, value, Widget child) { return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Controls(Icons.repeat,(){value.playerAudio(reciter.server,snum);}),
            Controls(Icons.skip_previous,(){value.playerAudio(reciter.server, "${n-1}");}),
            PlayControl(Icons.play_arrow,reciter,snum,numberList),
            Controls(Icons.skip_next,(){value.playerAudio(reciter.server, "${n+1}");}),
            Controls(Icons.shuffle,(){}),
          ],
        ),
      ); },

    );
  }
}

class PlayControl extends StatelessWidget {

  IconData icon; Reciter reciter; String snum; List<String> numberList;
  PlayControl(this.icon, this.reciter, this.snum, this.numberList);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAudio>(
      builder: (context, myAudioModel, child) {

       return GestureDetector(
          onTap: (){
            //myAudioModel.pauseAudio();
           myAudioModel.audioState=="Playing"?myAudioModel.pauseAudio():myAudioModel.playerAudio(reciter.server, snum);
            print(myAudioModel.audioState);
          },
          child: Container(
              height: 100.0,
              width: 100.0,
              decoration: buildBoxDecoration(),
              child:buildIcon(myAudioModel.audioState=="Playing"?Icons.pause:icon,50)
          ),
        );
      },

    );
  }
}

class Controls extends StatelessWidget {
  IconData icon;
  Function callbackpress;
  Controls(this.icon,  this.callbackpress);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callbackpress,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: buildBoxDecoration(),
        child:buildIcon(icon,25)


       // Icon(icon),
      ),
    );
  }




}
BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
          color: darkPrimaryColor,
          offset: Offset(20, 8),
          spreadRadius: 3,
          blurRadius: 25),
      BoxShadow(
          color: Colors.white,
          offset: Offset(-3, -4),
          spreadRadius: -2,
          blurRadius: 20)
    ],
  );
}

Stack buildIcon(IconData icon,double size) {
  return Stack(

    children: [
      Center(
        child: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(color: Colors.grey,shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: darkPrimaryColor,
                  offset: Offset(20, 8),
                  spreadRadius: 3,
                  blurRadius: 25),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-3, -4),
                  spreadRadius: -2,
                  blurRadius: 20)
            ],
          ),

          //  child:Icon(icon) ,
        ),
      ),

      Center(

        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: primaryColor,shape: BoxShape.circle),
          child:Center(child: Icon(icon,size: size,color: darkPrimaryColor,)) ,
        ),
      )
    ],
  );
}