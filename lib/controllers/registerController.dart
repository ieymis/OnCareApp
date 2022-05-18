import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:on_care/screens/home/home.dart';
import 'package:on_care/screens/home/mainHomeUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController{

  var isLoading = false.obs;
  var isSecondPage = false.obs;
  var registerKey = GlobalKey<FormState>().obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController weight = TextEditingController();

  var age = ''.obs;
  var gender = ''.obs;

  var agesList = List<int>.generate(100, (index) => index + 1);
  var weightList = List<int>.generate(200, (index) => index + 1);

  String api = "http://humanvitals.000webhostapp.com/api";

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isSecondPage(false);
  }

  void register(context) {
    isLoading(true);
    debugPrint('register start');
    var url = Uri.parse("$api/register_user");
    try {
      post(url, body: {
        "name": name.text,
        "phone": phone.text,
        "email": email.text,
        "password": password.text,
        "weight": weight.text,
        "age": age.value,
        "gender": gender.value,
      }).then((value) {
        var response = json.decode(value.body);

        isLoading(false);
        debugPrint('register  ${value.body}  ');
        if(response['status']){
          SharedPreferences.getInstance().then((value){
            value.setBool("logged", true);
            value.setString("id", response['id'][0]['id'].toString());
            value.setString("type", 'U' );
          });
          Get.offAll(() => MainHomeUser());

        }
        else{
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
      }).timeout(const Duration(seconds: 10)).catchError((e) {
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