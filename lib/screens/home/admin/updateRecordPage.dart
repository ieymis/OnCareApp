import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/controllers/adminHomeController.dart';

import '../../../constants/constants.dart';
import '../../../widget/textField.dart';

class UpdateRecordPage extends StatefulWidget {
  const UpdateRecordPage({Key? key}) : super(key: key);

  @override
  _UpdateRecordPageState createState() => _UpdateRecordPageState();
}

class _UpdateRecordPageState extends State<UpdateRecordPage> {
  AdminHomeController adminHomeController = Get.put(AdminHomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      adminHomeController.getInfoById(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(() => SafeArea(
            child: adminHomeController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: Constants.main,
                    ),
                  )
                : Padding(
                  padding: const EdgeInsets.only(top: 40.0,left: 10,right: 10),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                adminHomeController.user.value.gender == 'Male'
                                    ? 'assets/images/per1.png'
                                    : 'assets/images/per2.png',
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          viewInfo(size),
                          SizedBox(height: 20,),
                          updateFrom(size)
                        ],
                      ),
                    ],
                  ),
                ),
          )),
    );
  }

  updateFrom(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: adminHomeController.updateRecKey.value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Body Temperature',
              controller: adminHomeController.body_temperature,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Respiratory Rate',
              controller: adminHomeController.respiratory_rate,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Heart Rate',
              controller: adminHomeController.hart_rate,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Blood Pressure',
              controller: adminHomeController.blood_perssure,
            ),
            SizedBox(
              height: 30,
            ),
            updateButton(size)
          ],
        ),
      ),
    );
  }

  updateButton(size) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          if (!adminHomeController.isUpdateLoading.value) {
            if (adminHomeController.updateRecKey.value.currentState!
                .validate()) {
              adminHomeController.updateRecord(context);
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
          child: Obx(() => adminHomeController.isUpdateLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text(
                  "Update",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
        ),
      ),
    );
  }

  viewInfo(size) {
    return Column(
      children: [
        Text(adminHomeController.user.value.username,style: TextStyle(fontSize: 30),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Email',style: TextStyle(fontSize: 20,color: Constants.button),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(adminHomeController.user.value.email),
                  ),
                ],
              ),

              Column(
                children: [
                  Text('Phone',style: TextStyle(fontSize: 20,color: Constants.button),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(adminHomeController.user.value.phone_number),
                  ),
                ],
              )

            ],
          ),
        ),

      ],
    );
  }
}
