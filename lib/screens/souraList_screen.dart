import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'package:quran_kareem/colors.dart';


import 'package:quran_kareem/screens/playing_screen.dart';
import 'package:quran_kareem/services/quran_service.dart';

import 'package:quran_kareem/services/sours_servies.dart';

class SouraListScreen extends StatefulWidget {
  Reciter reciter;

  SouraListScreen(this.reciter);

  @override
  _SouraListState createState() => _SouraListState();
}

class _SouraListState extends State<SouraListScreen> {
  List<String> numberList;
  List<Surahs> surahs;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var res =
        await http.get("https://unpkg.com/quran-json@1.0.1/json/surahs.json");
    surahs = surahsFromJson(res.body);
    setState(() {});
  }

  List<String> mylistNumber() {
    var string = widget.reciter.suras;
    numberList = string.split(",");
    return numberList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(title: Text("السور"),backgroundColor: primaryColor.withOpacity(0.1),),
      body: surahs == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : soursListNames(),
    );
  }

  soursListNames() {
    return ListView.builder(
        itemCount: mylistNumber().length,
        itemBuilder: (context, index) {
          String Snum = mylistNumber()[index].padLeft(3, '0');
          // String Snum = mylistNumber()[index].padLeft(3, '0');
          String Sname = surahs[int.parse(mylistNumber()[index]) - 1].name;
          int i = index;
          return Card(
            elevation: 5.0,
            color: primaryColor.withOpacity(0.8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60.0))),
            child: ListTile(
              title: Text(surahs == null ? "..." : Sname,style: TextStyle(color: darkPrimaryColor,fontSize: 28),textAlign:TextAlign.center ,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {

                  return PlayingScreen(

                      widget.reciter, surahs, numberList, i, Snum);
                }));
              },
            ),
          );
        });
  }
}
