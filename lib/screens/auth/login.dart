import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_care/constants/constants.dart';
import 'package:on_care/controllers/loginController.dart';
import 'package:on_care/controllers/registerController.dart';
import 'package:on_care/screens/auth/register.dart';
import 'package:on_care/widget/textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: loginController.loginKey.value,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0,left: 20,right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/onecare.png'),
                    ),
                    SizedBox(height: 40,),
                    Text('Email',style: TextStyle(color: Colors.black54),),
                    CustomTextField(
                      controller: loginController.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20,),

                    Text('Password',style: TextStyle(color: Colors.black54),),
                    CustomTextField(
                      controller: loginController.password,
                      isPass: true,
                    ),
                    SizedBox(height: 50,),
                    loginButton(size),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginButton(size) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if (!loginController.isLoading.value) {
                if (loginController.loginKey.value.currentState!
                    .validate()) {
                  loginController.login(context);
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.all(0),
              child: Obx(() => loginController.isLoading.value
                  ? const CircularProgressIndicator(
                color: Colors.white,
              )
                  : const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have account?"),
              TextButton(onPressed: ()=> Get.off(()=> RegisterPage()), child: Text('Register',style: TextStyle(color: Constants.main,),),),
            ],
          )
        ],
      ),
    );
  }
  
}
