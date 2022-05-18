import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../controllers/msgsController.dart';
import '../home/mainHomeScreens/msgSupport.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  MessagesController messagesController = Get.put(MessagesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      messagesController.getMsgsReq(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => messagesController.isMsgLoading.value
            ? CircularProgressIndicator(
                color: Constants.main,
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Messages',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    reqList()
                  ],
                ),
              )),
      ),
    );
  }

  reqList() {
    return Expanded(
      child: ListView.builder(
        itemCount: messagesController.msgsReq.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            messagesController
                .userId('${messagesController.msgsReq[index].record_id}');
            messagesController
                .userName('${messagesController.msgsReq[index].username}');
            debugPrint('test  ${messagesController.msgsReq[index].record_id}');
            Get.to(() => SupportMsgs());
          },
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Constants.main,
                        child: Image.asset(
                          messagesController.msgsReq[index].gender == 'Male'
                              ? 'assets/images/per1.png'
                              : 'assets/images/per2.png',
                          height: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(messagesController.msgsReq[index].username),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Constants.main,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
