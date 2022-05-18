import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/constants/constants.dart';
import 'package:on_care/screens/auth/login.dart';
import 'package:on_care/screens/msgSupport/msgsPage.dart';
import 'package:on_care/screens/start.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/adminHomeController.dart';
import 'admin/updateRecordPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdminHomeController adminHomeController = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/onecare.png'),
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ),
                adminHomeController.isLoading.value
                    ? Center(child: CircularProgressIndicator(color: Constants.button,))
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Records',
                        style: TextStyle(fontSize: 30, color: Constants.main),
                      ),
                      adminHomeController.isLoading.value
                          ? Container()
                          : recordsList(size)
                    ],
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'msg',
            onPressed: () {
              Get.to(() => MessagesPage());
            },
            backgroundColor: Constants.main,
            child: Icon(
              Icons.message_outlined,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FloatingActionButton(
              heroTag: 'logout',
              onPressed: () {
                SharedPreferences.getInstance().then((value) {
                  value.clear();
                  Get.offAll(() => StartPage());
                });
              },
              backgroundColor: Constants.main,
              child: Icon(
                Icons.logout,
              ),
            ),
          ),
        ],
      ),
    );
  }

  recordsList(size) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 75.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: adminHomeController.recordsList.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ExpansionTile(
                childrenPadding: EdgeInsets.zero,
                tilePadding: EdgeInsets.zero,
                title: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Name ',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          TextSpan(
                            text:
                                adminHomeController.recordsList[index].username,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Constants.main),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                                onTap: () {
                                  adminHomeController.userId(adminHomeController.recordsList[index].id);
                                  adminHomeController.recordId(adminHomeController.recordsList[index].record_id);
                                  Get.to(()=>UpdateRecordPage());
                                },
                            borderRadius: BorderRadius.circular(50),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Constants.main,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                            onTap: () {
                              adminHomeController.deleteRecord(context, index);
                            },
                            borderRadius: BorderRadius.circular(50),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width / 2.5,
                        child: ListTile(
                          title: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${adminHomeController.recordsList[index].email}',
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2.5,
                        child: ListTile(
                          title: Text(
                            'Phone',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${adminHomeController.recordsList[index].phone_number}',
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width / 2.5,
                        child: ListTile(
                          title: Text(
                            'Age',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${adminHomeController.recordsList[index].age}',
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                      Container(
                          width: size.width / 2.5,
                        child: ListTile(
                          title: Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${adminHomeController.recordsList[index].gender}',
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(color: Constants.button,height: 1,),
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width / 2.5,
                        child: ListTile(
                          title: Text(
                            'Blood Pressure',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${adminHomeController.recordsList[index].blood_pressure}',
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2.5,
                        child: ListTile(
                          title: Text(
                            'Heart Rate',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${adminHomeController.recordsList[index].hart_rate}',
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width / 2.5,
                        child: ListTile(
                          title: Text(
                            'Respiratory Rate',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${adminHomeController.recordsList[index].respiratory_rate}',
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2.5,
                        child: ListTile(
                          title: Text(
                            'Body Temperature',
                            style: TextStyle(
                                fontSize: 15, color: Constants.button),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${adminHomeController.recordsList[index].body_temperature}',
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
