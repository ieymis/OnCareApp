import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:on_care/modal/user.dart';
import 'package:on_care/screens/home/home.dart';
import 'package:on_care/screens/home/mainHomeScreens/home.dart';
import 'package:on_care/screens/home/mainHomeScreens/msgSupport.dart';
import 'package:on_care/screens/home/mainHomeUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home/mainHomeScreens/profile.dart';
import 'msgsController.dart';

class HomeController extends GetxController {
  var pageIndex = 0.obs;
  var isLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isEditing = false.obs;

  var profileKey = GlobalKey<FormState>().obs;

  var user = Rx<User>(User('', '', '', '', '', 0, '', 0, '', '', '', '', ''));

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController weight = TextEditingController();

  var gender = ''.obs;

  MessagesController messagesController = Get.put(MessagesController());


  String api = "http://humanvitals.000webhostapp.com/api";

  //todo come back
  getInfo(context) async {
    isLoading(true);
    debugPrint('getInfo start');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var url = Uri.parse("$api/show_record_by_id");
    try {
      post(url, body: {'id': preferences.getString('id')})
          .then((value) {
            var response = json.decode(value.body);

            isLoading(false);
            debugPrint('getInfo  ${value.body}  ');
            if (response['status']) {
              user(User.fromJson(response['Record'][0]));
              preferences.setString('record_id', user.value.record_id);
              name.text = user.value.username;
              age.text = user.value.age.toString();
              phone.text = user.value.phone_number;
              email.text = user.value.email;
              weight.text = user.value.weight.toString();
              gender(user.value.gender);
              checkUserSafety(context);
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
            debugPrint('getInfo  Exception $e');
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
      debugPrint('getInfo  Exception $e');
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

  addRecord(context) async {
    isLoading(true);
    Random random = Random();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    debugPrint('addRecord start  ${35 + random.nextInt(4)}  -- ${preferences.containsKey('record_id')}');

    var url = Uri.parse("$api/add_record");
    try {
      post(url,
              body: preferences.containsKey('record_id')
                  ? {
                      'record_id': preferences.getString('record_id')!,
                      'body_temperature': (35 + random.nextInt(4)).toString(),
                      'blood_perssure': (75 + random.nextInt(50)).toString(),
                      'hart_rate': (55 + random.nextInt(50)).toString(),
                      'respiratory_rate': (7 + random.nextInt(10)).toString()
                    }
                  : {
                      'id': preferences.getString('id')!,
                      'body_temperature': (35 + random.nextInt(4)).toString(),
                      'blood_perssure': (75 + random.nextInt(50)).toString(),
                      'hart_rate': (55 + random.nextInt(50)).toString(),
                      'respiratory_rate': (7 + random.nextInt(10)).toString()
                    })
          .then((value) {
            var response = json.decode(value.body);

            isLoading(false);
            debugPrint('addRecord  ${value.body}  ');
            if (response['status']) {
              getInfo(context);
            } else {
              // showToast(response['msg'] ?? 'Something went wrong!',
              //     context: context,
              //     animation: StyledToastAnimation.slideFromTop,
              //     position: StyledToastPosition.top,
              //     animDuration: Duration(seconds: 1),
              //     duration: Duration(seconds: 4),
              //     backgroundColor: Colors.red,
              //     curve: Curves.elasticOut,
              //     reverseCurve: Curves.fastOutSlowIn);
            }
          })
          .timeout(const Duration(seconds: 10))
          .catchError((e) {
            isLoading(false);
            debugPrint('addRecord  Exception $e');
            // showToast('Something went wrong!',
            //     context: context,
            //     animation: StyledToastAnimation.slideFromTop,
            //     position: StyledToastPosition.top,
            //     animDuration: Duration(seconds: 1),
            //     duration: Duration(seconds: 4),
            //     backgroundColor: Colors.red,
            //     curve: Curves.elasticOut,
            //     reverseCurve: Curves.fastOutSlowIn);
          });
    } on Exception catch (e) {
      // TODO
      isLoading(false);
      debugPrint('addRecord Exception $e');
      // showToast('Something went wrong!',
      //     context: context,
      //     animation: StyledToastAnimation.slideFromTop,
      //     position: StyledToastPosition.top,
      //     animDuration: Duration(seconds: 1),
      //     duration: Duration(seconds: 4),
      //     backgroundColor: Colors.red,
      //     curve: Curves.elasticOut,
      //     reverseCurve: Curves.fastOutSlowIn);
    }
  }

  updateProfile(context) async {
    isUpdateLoading(true);
    Random random = Random();
    debugPrint('addRecord start  ${35 + random.nextInt(4)}  -- ');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var url = Uri.parse("$api/update_profile");
    try {
      post(url, body: {
        'id': preferences.getString('id')!,
        'username': name.text,
        'email': email.text,
        'password': password.text,
        'age': age.text,
        'gender': gender.value,
        'weight': weight.text,
        'phone_number': phone.text,
      })
          .then((value) {
            var response = json.decode(value.body);

            isUpdateLoading(false);
            debugPrint('addRecord  ${value.body}  ');
            if (response['status']) {
              showToast('Updated Successfully!',
                  context: context,
                  animation: StyledToastAnimation.slideFromTop,
                  position: StyledToastPosition.top,
                  animDuration: Duration(seconds: 1),
                  duration: Duration(seconds: 4),
                  backgroundColor: Colors.green,
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.fastOutSlowIn);
               password.clear();

              isEditing(false);
              getInfo(context);
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
        isUpdateLoading(false);
            debugPrint('addRecord  Exception $e');
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
      isUpdateLoading(false);
      debugPrint('addRecord Exception $e');
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

  checkUserSafety(context) {
    if(int.parse(user.value.blood_pressure) < 80 || int.parse(user.value.blood_pressure) > 120){
      sendDoctorMsg('Blood Pressure', user.value.blood_pressure, int.parse(user.value.blood_pressure) < 80, context,);
    }
    if(int.parse(user.value.body_temperature) < 36 || int.parse(user.value.body_temperature) > 38){
      sendDoctorMsg('Body Temperature', user.value.body_temperature, int.parse(user.value.body_temperature) < 36,context);
    }
    if(int.parse(user.value.respiratory_rate) < 9 || int.parse(user.value.respiratory_rate) > 15){
      sendDoctorMsg('Respiratory Rate', user.value.respiratory_rate, int.parse(user.value.respiratory_rate) < 9, context);
    }
    if(int.parse(user.value.hart_rate) < 65 || int.parse(user.value.hart_rate) > 100){
      sendDoctorMsg('Heart Rate', user.value.hart_rate, int.parse(user.value.hart_rate) < 65, context);
    }
  }

  sendDoctorMsg(issue, measure,isLow, context ) async {
    AudioCache player = AudioCache();
    player.play('audio/alarm.mp3');

    HomeController homeController = Get.put(HomeController());
    homeController.pageIndex(1);
    Get.to(MainHomeUser());
    Future.delayed(Duration(seconds: 2),(){
    messagesController.msg.text = 'Warning! This user has an issue with $issue, the $issue is ${isLow ? 'LOW' : 'High'} :  $measure';
    messagesController.sendMsg(context);
    });

  }
}
