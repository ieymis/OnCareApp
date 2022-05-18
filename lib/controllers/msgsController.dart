import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:on_care/modal/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/user.dart';

class MessagesController extends GetxController {
  var isLoading = false.obs;
  var isMsgLoading = false.obs;
  var isMsgReqLoading = false.obs;
  var sent = false.obs;
  var msgKey = GlobalKey<FormState>().obs;
  var msgs = <Message>[].obs;
  var msgsReq = <User>[].obs;
  var userId = ''.obs;
  var userName = ''.obs;
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  TextEditingController msg = TextEditingController();
  var scrollController = Rx<ScrollController>(ScrollController());

  String api = "http://humanvitals.000webhostapp.com/api";


  sendMsg(context) async {
    isLoading(true);
    String message = msg.text;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String sender = preferences.getString('type')! == 'U' ? 'u' : 'a';
    String receiver = sender == 'u' ? 'a' : 'u$userId';
    debugPrint('sendMsg start  $userId -- ${preferences.getString('id')}');

    var url = Uri.parse("$api/add_message");
    try {
      post(url, body: {
        'sender_id': '$sender${preferences.getString('id')!}',
        'reciever_id': receiver,
        'message': message
      })
          .then((value) {
            var response = json.decode(value.body);

            isLoading(false);
            debugPrint('sendMsg  ${value.body}  ');
            if (response['status']) {
              msg.clear();
              getMsgs(context,false);

            } else {

              showToast( 'Something went wrong!',
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
            debugPrint('sendMsg  Exception $e');

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
      debugPrint('sendMsg Exception $e');

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

  getMsgs(context,showLoading) async {

    if (showLoading) {
      isMsgLoading(true);
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String sender = preferences.getString('type')! == 'U' ? 'u${preferences.getString('id')!}' : 'u$userId';
    String receiver = sender.contains('u') ? 'a' : 'a';
    debugPrint('getMsgs start  $sender $receiver');
    var url = Uri.parse("$api/show_message");
    try {
      post(url, body: {
        'sender_id': sender,
        'reciever_id': receiver
      })
          .then((value) {
            var response = json.decode(value.body);

            isMsgLoading(false);
            debugPrint('getMsgs  ${value.body}  ');
            if (response['status']) {
              msgs.clear();
              for(var msg in response['messages']){
                msgs.add(Message.fromJson(msg));
                debugPrint('tes msg  ${msgs[0].date.hour}');
              }
              if(!showLoading && msgs.length > 1){
                listKey.currentState!.insertItem(msgs.length - 1);
              }
              Future.delayed(Duration(milliseconds: 600),(){scrollToBottom();});
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
            isMsgLoading(false);
            debugPrint('getMsgs  Exception $e');
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
    }
    on Exception catch (e) {
      // TODO
      isMsgLoading(false);
      debugPrint('getMsgs  Exception $e');
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

  getMsgsReq(context) async {

    isMsgReqLoading(true);

    debugPrint('getMsgsReq start');

    var url = Uri.parse("$api/message_requests");
    try {
      get(url)
          .then((value) {
        var response = json.decode(value.body);

        isMsgReqLoading(false);
        debugPrint('getMsgsReq  ${value.body}  ');
        if (response['status']) {
          msgsReq.clear();
          for(var messageReq in response['info']){
            msgsReq.add(User.fromJson(messageReq));
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
        isMsgReqLoading(false);
        debugPrint('getMsgsReq  Exception $e');
        showToast('Something went wrong!',
            context: context,
            animation: StyledToastAnimation.slideFromTop,
            position: StyledToastPosition.top,
            animDuration: Duration(seconds: 1),
            duration: Duration(seconds: 4),
            backgroundColor: Colors.red,
            curve: Curves.elasticOut,
            reverseCurve: Curves.fastOutSlowIn);
      })
      ;
    } on Exception catch (e) {
      // TODO
      isMsgReqLoading(false);
      debugPrint('getMsgsReq  Exception $e');
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

  void scrollToBottom() {
    print('test ${scrollController.value.position.maxScrollExtent}');
    scrollController.value.notifyListeners();
    final bottomOffset = scrollController.value.position.maxScrollExtent;
    scrollController.value.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

}
