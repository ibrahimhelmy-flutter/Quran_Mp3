import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_kareem/model/myAudio.dart';
import 'package:quran_kareem/screens/home_screen.dart';
import 'package:quran_kareem/screens/playing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAudio>(
      create: (context) => MyAudio(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomeScreen(),
      ),
    );
  }
}

