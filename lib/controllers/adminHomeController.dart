import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:on_care/modal/user.dart';

class AdminHomeController extends GetxController{

  var recordsList = <User>[].obs;
  var isLoading = false.obs;
  var isUpdateLoading = false.obs;
  var recordId = ''.obs;
  var userId = ''.obs;
  var updateRecKey = GlobalKey<FormState>().obs;
  var user = Rx<User>(User('', '', '', '', '', 0, '', 0, '', '', '', '', ''));


  var body_temperature = TextEditingController();
  var blood_perssure   = TextEditingController();
  var hart_rate        = TextEditingController();
  var respiratory_rate = TextEditingController();

  String api = "http://humanvitals.000webhostapp.com/api";


  @override
  void onInit() {
    getInfo(Get.context);
  }

  getInfo(context) async {
    isLoading(true);
    debugPrint('getInfo start');

    var url = Uri.parse("$api/show_record");
    try {
      get(url)
          .then((value) {
        var response = json.decode(value.body);

        isLoading(false);
        debugPrint('getInfo  ${value.body}  ');
        if (response['status']) {
          recordsList.clear();
          for(var record in response['Record']) {
            recordsList.add(User.fromJson(record));
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

  getInfoById(context) async {
    isLoading(true);
    debugPrint('getInfo start');

    var url = Uri.parse("$api/show_record_by_id");
    try {
      post(url,body: {
        'id': userId.value
      })
          .then((value) {
        var response = json.decode(value.body);

        isLoading(false);
        debugPrint('getInfo  ${value.body}  ');
        if (response['status']) {
          user(User.fromJson(response['Record'][0]));

          body_temperature.text = user.value.body_temperature;
          blood_perssure.text = user.value.blood_pressure;
          hart_rate.text = user.value.hart_rate;
          respiratory_rate.text = user.value.respiratory_rate;
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

  updateRecord(context) async {
    isLoading(true);

    debugPrint('updateRecord start');

    var url = Uri.parse("$api/add_record");
    try {
      post(url,
          body:  {
            'record_id': recordId.value,
            'body_temperature': body_temperature.text,
            'blood_perssure': blood_perssure.text,
            'hart_rate': hart_rate.text,
            'respiratory_rate': respiratory_rate.text
          })
          .then((value) {
        var response = json.decode(value.body);

        isLoading(false);
        debugPrint('updateRecord  ${value.body}  ');
        if (response['status']) {
          showToast('Updated Successfully',
              context: context,
              animation: StyledToastAnimation.slideFromTop,
              position: StyledToastPosition.top,
              animDuration: Duration(seconds: 1),
              duration: Duration(seconds: 4),
              backgroundColor: Colors.green,
              curve: Curves.elasticOut,
              reverseCurve: Curves.fastOutSlowIn);
          Get.back();
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
        isLoading(false);
        debugPrint('updateRecord  Exception $e');
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
      debugPrint('updateRecord Exception $e');
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

  deleteRecord( context, int index) {

     debugPrint('deleteRecord start');

     var url = Uri.parse("$api/delete_record");
     try {
       post(url,body: {
         'id' : recordsList[index].record_id
       })
           .then((value) {
         var response = json.decode(value.body);

         debugPrint('deleteRecord  ${value.body}  ');
         if (response['status']) {
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
         isLoading(false);
         debugPrint('deleteRecord  Exception $e');
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
       debugPrint('deleteRecord  Exception $e');
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