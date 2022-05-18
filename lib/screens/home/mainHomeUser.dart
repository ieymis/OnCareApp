import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/constants/constants.dart';
import 'package:on_care/controllers/homeController.dart';

import 'home.dart';
import 'mainHomeScreens/home.dart';
import 'mainHomeScreens/msgSupport.dart';
import 'mainHomeScreens/profile.dart';

class MainHomeUser extends StatefulWidget {
  final String? source;

  const MainHomeUser({Key? key, this.source}) : super(key: key);

  @override
  _MainHomeUserState createState() => _MainHomeUserState();
}

class _MainHomeUserState extends State<MainHomeUser> {
  HomeController homeController = Get.put(HomeController());
  var pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      UserHomePage(
        source: widget.source,
      ),
      SupportMsgs(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() => Scaffold(
          backgroundColor: Constants.white,
          body: pages[homeController.pageIndex.value],
          bottomSheet: Container(
            color: Constants.white,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 8.0, left: size.width / 7, right: size.width / 7),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => homeController.pageIndex(0),
                          icon: Icon(
                            Icons.home_outlined,
                            color: homeController.pageIndex.value == 0
                                ? Constants.button
                                : Colors.black38,
                          )),
                      IconButton(
                        onPressed: () => homeController.pageIndex(1),
                        padding: EdgeInsets.zero,
                        icon: CircleAvatar(
                          radius: 50,
                          backgroundColor: Constants.button,
                          child: Icon(Icons.message_outlined,color: Constants.white),
                        ),
                      ),
                      IconButton(
                          onPressed: () => homeController.pageIndex(2),
                          icon: Icon(Icons.person_outlined,
                              color: homeController.pageIndex.value == 2
                                  ? Constants.button
                                  : Colors.black38)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
