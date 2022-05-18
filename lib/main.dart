import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/constants/constants.dart';
import 'package:on_care/screens/auth/register.dart';
import 'package:on_care/screens/start.dart';

void main() {
  runApp(GetMaterialApp(
      theme: ThemeData(fontFamily: 'playfair'), home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One-Care',
      theme: ThemeData(
        fontFamily: 'playfair',
        primarySwatch: Constants().createMaterialColor(Constants.main)
      ),
      home: const StartPage(),
    );
  }
}
