import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:quran_kareem/colors.dart';

import 'package:quran_kareem/screens/souraList_screen.dart';
import 'package:quran_kareem/services/quran_service.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  Quran quran;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var res = await http.get("http://mp3quran.net/api/_arabic.php");

    quran = quranFromJson(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(title: Text("الشيوخ"),centerTitle: true,backgroundColor: primaryColor.withOpacity(0.1),),
      body: quran == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: quran.reciters.length,
              itemBuilder: (context, index) {
                Reciter reciter = quran.reciters[index];

                return Card(
                      color: primaryColor.withOpacity(0.7),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60.0))),
                  child: ListTile(
                    title: Text(
                      reciter.name,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: darkPrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SouraListScreen(reciter)));
                    },
                  ),
                );
              }),
    );
  }
}
