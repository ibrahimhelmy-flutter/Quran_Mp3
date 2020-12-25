import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_kareem/colors.dart';
import 'package:quran_kareem/model/myAudio.dart';
import 'package:quran_kareem/services/sours_servies.dart';
import 'package:quran_kareem/widget/album_art.dart';
import 'package:quran_kareem/widget/navbar.dart';
import 'package:quran_kareem/widget/playerControls.dart';

import '../services/quran_service.dart';

class PlayingScreen extends StatefulWidget {
  Reciter reciter;
  List<Surahs> surahs;
  List<String> numberList;
  int index;
  String snum;

  PlayingScreen(
      this.reciter, this.surahs, this.numberList, this.index, this.snum);

  @override
  _PlayingScreenState createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {


  void myplay() {
    Provider.of<MyAudio>(context, listen: false)
        .playerAudio(widget.reciter.server, widget.snum);
  }

  @override
  Widget build(BuildContext context) {
    myplay();

    String Sname =
        widget.surahs[int.parse(widget.numberList[widget.index]) - 1].name;

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<MyAudio>(
              builder: (_, myModelAduio, Widget child) => Column(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavigationBar(),
                  Container(
                    height: height / 2.5,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return AlbumArt();
                      },
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Text(
                    widget.surahs == null ? "..." : "$Sname",
                    style: TextStyle(
                        fontSize: 30,
                        color: darkPrimaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    " القاري: ${widget.reciter.name}",
                    style: TextStyle(
                        fontSize: 20,
                        color: darkPrimaryColor,
                        fontWeight: FontWeight.w400),textDirection: TextDirection.rtl,
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 5,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                    ),
                    child: Slider(
                      value: myModelAduio.position == null
                          ? 0
                          : myModelAduio.position.inMilliseconds.toDouble(),
                      activeColor: darkPrimaryColor,
                      inactiveColor: darkPrimaryColor.withOpacity(0.3),
                      onChanged: (value) {
                        myModelAduio
                            .seekAudio(Duration(milliseconds: value.toInt()));
                      },
                      min: 0,
                      max: myModelAduio.totalDuration == null
                          ? 1000
                          : myModelAduio.totalDuration.inMilliseconds.toDouble(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(myModelAduio.position.toString().split(".").first),
                      Text(myModelAduio.totalDuration.toString().split(".").first),
                    ],
                  ),
                  PlayerControls(widget.reciter, widget.snum, widget.numberList),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
