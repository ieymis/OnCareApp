import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/constants/constants.dart';
import 'package:on_care/controllers/registerController.dart';
import 'package:on_care/screens/auth/login.dart';
import 'package:on_care/screens/auth/register.dart';
import 'package:on_care/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/mainHomeUser.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      SharedPreferences.getInstance().then((value) {
        print('test  ${value.getBool('logged')}  ${value.getString('type')}');
        if(value.containsKey('logged') && value.getBool('logged')!) {
          if (value.getString('type') == 'U') {
            Get.offAll(() => MainHomeUser());
          }
          else{
            Get.offAll(() => HomePage());
          }
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/onecare.png'),
                ),
                SizedBox(height: 20,),
                Text(
                  'One-Care',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 10,),
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Constants.main),
                ),

                SizedBox(height: 40,),
                registerButton(size),
                SizedBox(height: 20,),
                loginButton(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  registerButton(size) {
    return ElevatedButton(
      onPressed: () => Get.to(()=>RegisterPage()),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        backgroundColor: MaterialStateProperty.all(Constants.button),
        fixedSize: MaterialStateProperty.all(Size(size.width / 1.5, 50)),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: Colors.white,
          ))),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0),
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  loginButton(size) {
    return ElevatedButton(
      onPressed: () => Get.to(()=>LoginPage()),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        backgroundColor: MaterialStateProperty.all(Constants.button),
        fixedSize: MaterialStateProperty.all(Size(size.width / 1.5, 50)),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: Colors.white,
          ))),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0),
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
