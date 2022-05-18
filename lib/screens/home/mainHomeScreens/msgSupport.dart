import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../controllers/msgsController.dart';
import '../../../widget/textField.dart';

class SupportMsgs extends StatefulWidget {
  final userID;

  const SupportMsgs({Key? key, this.userID}) : super(key: key);

  @override
  _SupportMsgsState createState() => _SupportMsgsState();
}

class _SupportMsgsState extends State<SupportMsgs> {
  MessagesController messagesController = Get.put(MessagesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        messagesController.getMsgs(context, true,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: messagesController.isMsgLoading.value
                    ? CircularProgressIndicator(
                        color: Constants.main,
                      )
                    : messagesController.msgs.isEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text(
                                  'Contact US',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text('We are here for you'),
                                const SizedBox(
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: messagesController.msgKey.value,
                                    child: CustomTextField(
                                      maxLines: 5,
                                      hintText: 'Message',
                                      controller: messagesController.msg,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                sendButton(size)
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(bottom: messagesController.userName.value != '' ? 0.0: 60.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    messagesController.userName.value != ''
                                        ? messagesController.userName.value
                                        : 'Support',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                msgs(),
                                Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Form(
                                            key:
                                                messagesController.msgKey.value,
                                            child: CustomTextField(
                                              hintText: 'Message',
                                              controller:
                                                  messagesController.msg,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            if (messagesController
                                                .msgKey.value.currentState!
                                                .validate()) {
                                              messagesController
                                                  .sendMsg(context);
                                            }
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor: Constants.button,
                                            child: messagesController
                                                    .isLoading.value
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Icon(
                                                    Icons.send,
                                                    color: Constants.white,
                                                    size: 18,
                                                  ),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
              ),
            )),
      ),
    );
  }

  sendButton(size) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () async {
          if (!messagesController.isLoading.value) {
            if (messagesController.msgKey.value.currentState!.validate()) {
              await messagesController.sendMsg(context);
            }
          }
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(10),
            backgroundColor: MaterialStateProperty.all(Constants.button),
            fixedSize: MaterialStateProperty.all(Size(size.width / 1.5, 50)),
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: size.width * 0.3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.all(0),
          child: Obx(() => messagesController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text(
                  "Submit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
        ),
      ),
    );
  }

  msgs() {
    return Expanded(
      child: AnimatedList(
        controller: messagesController.scrollController.value,
        key: messagesController.listKey,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 8.0),
        physics: const ScrollPhysics(),
        initialItemCount: messagesController.msgs.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: Column(children: [
              ExpandablePanel(
                header: Directionality(
                  textDirection: messagesController.userId.value == ''
                      ? (messagesController.msgs[index].sender_id.contains('a')
                          ? m.TextDirection.ltr
                          : m.TextDirection.rtl)
                      : (!messagesController.msgs[index].sender_id.contains('a')
                          ? m.TextDirection.ltr
                          : m.TextDirection.rtl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: messagesController.msgs[index].message
                                .startsWith('Warning')
                            ? Colors.amber
                            : (messagesController.userId.value == ''
                                ? (messagesController.msgs[index].sender_id
                                        .contains('a')
                                    ? Constants.button.withOpacity(0.5)
                                    : Constants.main)
                                : (!messagesController.msgs[index].sender_id
                                        .contains('a')
                                    ? Constants.button.withOpacity(0.5)
                                    : Constants.main)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: Text(
                            messagesController.msgs[index].message,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                collapsed: Container(),
                expanded: Align(
                  alignment: messagesController.userId.value == ''
                      ? (messagesController.msgs[index].sender_id.contains('a')
                          ? Alignment.topLeft
                          : Alignment.topRight)
                      : (!messagesController.msgs[index].sender_id.contains('a')
                          ? Alignment.topLeft
                          : Alignment.topRight),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Text(
                      DateFormat('yy/MM/dd – kk:mm')
                          .format(messagesController.msgs[index].date),
                      softWrap: true,
                    ),
                  ),
                ),
                theme: ExpandableThemeData(hasIcon: false, useInkWell: false),
              ),
            ]),
          );
        },
      ),
    );
  }
}
