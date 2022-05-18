import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/constants/constants.dart';
import 'package:on_care/controllers/homeController.dart';

class UserHomePage extends StatefulWidget {
  final String? source;

  const UserHomePage({Key? key, this.source}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      if(widget.source == 'login') {
        await homeController.getInfo(context);
      }

        homeController.addRecord(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.white,
      body: SafeArea(
        child: Obx(() => homeController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                color: Constants.main,
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8, right: 8),
                  child: Column(
                    children: [
                      Text(
                        'Hello ${homeController.user.value.username}',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      info(size)
                    ],
                  ),
                ),
              )),
      ),
    );
  }

  info(size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/respiratory.png'),
                  Column(
                    children: [
                      Text(
                        'Respiratory rate',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${homeController.user.value.respiratory_rate}'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/rate.png'),
                      Text(
                        'Heart rate',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${homeController.user.value.hart_rate}'),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/hrate.png'),
                      Text(
                        'Blood pressure',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${homeController.user.value.blood_pressure}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/tempr.png',height: 130,),
                  Column(
                    children: [
                      Text(
                        'Body Temperature',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${homeController.user.value.body_temperature}'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
