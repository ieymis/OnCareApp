import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/constants/constants.dart';
import 'package:on_care/screens/start.dart';
import 'package:on_care/widget/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/homeController.dart';
import '../../../widget/dropItemField.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Constants.white,
        body: SafeArea(
          child: Obx(() => Padding(
                padding: EdgeInsets.only(
                    bottom: homeController.isEditing.value ? 55.0 : 0,
                    top: homeController.isEditing.value ? 0 : 55.0),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      homeController.user.value.gender == 'Male'
                                          ? 'assets/images/per1.png'
                                          : 'assets/images/per2.png',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: homeController.isEditing.value
                                      ? updateFrom(size)
                                      : viewInfo(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ));
  }

  viewInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10, bottom: 10),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    homeController.user.value.username,
                    style: TextStyle(fontSize: 20, color: Constants.button),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10, bottom: 10),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Age',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${homeController.user.value.age}',
                    style: TextStyle(fontSize: 20, color: Constants.button),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10, bottom: 10),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${homeController.user.value.email}',
                    style: TextStyle(fontSize: 20, color: Constants.button),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10, bottom: 10),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Number',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${homeController.user.value.phone_number}',
                    style: TextStyle(fontSize: 20, color: Constants.button),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () => homeController.isEditing(true),
                child: Text('Change')),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => SharedPreferences.getInstance().then((value) {
              value.clear();
              Get.offAll(() => StartPage());
            }),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Constants.button,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Log out',
                  style: TextStyle(
                      fontSize: 20,
                      color: Constants.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  updateFrom(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: homeController.profileKey.value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50)),
                  onTap: () => homeController.isEditing(false),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),
            CustomTextField(
              hintText: 'Name',
              controller: homeController.name,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Email',
              controller: homeController.email,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Age',
              controller: homeController.age,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Phone',
              controller: homeController.phone,
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'Gender',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                ),
                validator: (value) => value == null ? 'Gender' : null,
                value: homeController.gender.value == ''
                    ? null
                    : homeController.gender.value,
                onChanged: (value) => homeController.gender(value.toString()),
                items: [
                  DropdownMenuItem(
                    child: Text('Male'),
                    value: 'Male',
                  ),
                  DropdownMenuItem(
                    child: Text('Female'),
                    value: 'Female',
                  ),
                ]),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Password',
              controller: homeController.password,
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
          if (!homeController.isUpdateLoading.value) {
            if (homeController.profileKey.value.currentState!.validate()) {
              homeController.updateProfile(context);
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
          child: Obx(() => homeController.isUpdateLoading.value
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
}
