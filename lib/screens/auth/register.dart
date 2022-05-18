import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/constants/constants.dart';
import 'package:on_care/controllers/registerController.dart';
import 'package:on_care/widget/dropItemField.dart';
import 'package:on_care/widget/textField.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => Form(
                key: registerController.registerKey.value,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: size.height / 8, left: 20, right: 20),
                    child: !registerController.isSecondPage.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Create Your Account',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Name',
                                style: TextStyle(color: Colors.black54),
                              ),
                              CustomTextField(
                                controller: registerController.name,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Email',
                                style: TextStyle(color: Colors.black54),
                              ),
                              CustomTextField(
                                controller: registerController.email,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Phone',
                                style: TextStyle(color: Colors.black54),
                              ),
                              CustomTextField(
                                controller: registerController.phone,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Password',
                                style: TextStyle(color: Colors.black54),
                              ),
                              CustomTextField(
                                controller: registerController.password,
                                isPass: true,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              registerButton(size)
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      )
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back_ios,color: Constants.main,),
                                      onPressed: () {
                                        registerController.isSecondPage(false);
                                      },
                                    ),
                                  ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Tell me more about yourself',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                              DropItemField(
                                width: size.width / 3,
                                text: 'Your Age',
                                dropdownItems:
                                    registerController.agesList.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      e.toString(),
                                    ),
                                    value: e.toString(),
                                  );
                                }).toList(),
                                hintText: 'Age',
                                value: registerController.age.value == ''
                                    ? null
                                    : registerController.age.value,
                                onChange: (value) =>
                                    registerController.age(value),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              DropItemField(
                                width: size.width / 3,
                                text: 'Your Gender',
                                hintText: 'Gender',
                                dropdownItems: [
                                  DropdownMenuItem(
                                    child: Text('Male'),
                                    value: 'Male',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Female'),
                                    value: 'Female',
                                  ),
                                ],
                                value: registerController.gender.value == ''
                                    ? null
                                    : registerController.gender.value,
                                onChange: (value) =>
                                    registerController.gender(value),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Card(
                                // color: Colors.white38,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width / 3,
                                        height: 70,
                                        child: CustomTextField(
                                          controller: registerController.weight,
                                          hintText: 'Weight',
                                        ),
                                      ),
                                      Text(
                                        'Your Weight',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              registerButton(size)
                            ],
                          ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  registerButton(size) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          registerController.isSecondPage.value
              ? ElevatedButton(
                  onPressed: () {
            if (!registerController.isLoading.value) {
                    if (registerController.registerKey.value.currentState!
                        .validate()) {
                      registerController.register(context);
                    }
                  }
      },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10),
                      backgroundColor:
                          MaterialStateProperty.all(Constants.button),
                      fixedSize:
                          MaterialStateProperty.all(Size(size.width / 1.5, 50)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                        color: Colors.white,
                      ))),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.all(0),
                    child: Obx(() => registerController.isLoading.value
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Register",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    if (registerController.registerKey.value.currentState!
                        .validate()) {
                      registerController.isSecondPage(true);
                    }
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10),
                      backgroundColor:
                          MaterialStateProperty.all(Constants.button),
                      fixedSize:
                          MaterialStateProperty.all(Size(size.width / 1.5, 50)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                        color: Colors.white,
                      ))),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Next    ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have account?'),
              TextButton(
                onPressed: () => Get.off(() => LoginPage()),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Constants.main,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
