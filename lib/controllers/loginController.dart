import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:on_care/screens/home/home.dart';
import 'package:on_care/screens/home/mainHomeUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var loginKey = GlobalKey<FormState>().obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String api = "http://humanvitals.000webhostapp.com/api";

  void login(context) {
    isLoading(true);
    debugPrint('login start');
    var url = Uri.parse("$api/login_user");
    try {
      post(url, body: {
        "email": email.text,
        "password": password.text,
      })
          .then((value) {
            var response = json.decode(value.body);

            isLoading(false);
            debugPrint('register  ${value.body}  ');
            if (response['status']) {
              SharedPreferences.getInstance().then((value) {
                value.setBool("logged", true);
                value.setString("id", response['id'][0]['id'].toString());
                value.setString(
                    "type", response['type'] == 'user' ? 'U' : 'A');
              });
              if (response['type'] == 'user') {
                Get.offAll(() => MainHomeUser(source: 'login',));
              }
              else{
                Get.offAll(() => HomePage());
              }
            } else {
              showToast(response['msg'] ?? 'Something went wrong!',
                  context: context,
                  animation: StyledToastAnimation.slideFromTop,
                  position: StyledToastPosition.top,
                  animDuration: Duration(seconds: 1),
                  duration: Duration(seconds: 4),
                  backgroundColor: Colors.red,
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.fastOutSlowIn);
            }
          })
          .timeout(const Duration(seconds: 10))
          .catchError((e) {
            isLoading(false);
            debugPrint('register  Exception $e');
            showToast('Something went wrong!',
                context: context,
                animation: StyledToastAnimation.slideFromTop,
                position: StyledToastPosition.top,
                animDuration: Duration(seconds: 1),
                duration: Duration(seconds: 4),
                backgroundColor: Colors.red,
                curve: Curves.elasticOut,
                reverseCurve: Curves.fastOutSlowIn);
          });
    } on Exception catch (e) {
      // TODO
      isLoading(false);
      debugPrint('register  Exception $e');
      showToast('Something went wrong!',
          context: context,
          animation: StyledToastAnimation.slideFromTop,
          position: StyledToastPosition.top,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
    }
  }
}
