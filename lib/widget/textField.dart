import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:on_care/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? icon;
  final String? hintText;
  final String? type;
  final bool? isPass;
  final int? maxLines;

  var showPassword = false.obs;
  var password = ''.obs;

  CustomTextField({
    Key? key,
    this.keyboardType,
    this.controller,
    this.icon,
    this.hintText,
    this.isPass = false,
    this.type,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(context) {
    // TODO: implement build
    return Obx(() => TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            if(hintText == 'Body Temperature'){
              if(int.parse(value) < 35 || int.parse(value) > 39){
                return 'Body Temperature ranging between 35 - 39';
              }
            }
            if(hintText == 'Respiratory Rate'){
              if(int.parse(value) < 6 || int.parse(value) > 18){
                return 'Respiratory Rate ranging between 6 - 18';
              }
            }
            if(hintText == 'Heart Rate'){
              if(int.parse(value) < 40 || int.parse(value) > 120){
                return 'Heart Rate ranging between 60 - 100';
              }
            }
            if(hintText == 'Blood Pressure'){
              if(int.parse(value) < 50 || int.parse(value) > 150){
                return 'Blood Pressure ranging between 80 - 120';
              }
            }

          },
          textAlignVertical: TextAlignVertical.top,
          maxLines: maxLines ?? 1,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: showPassword.value,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintStyle: TextStyle(),
            hintText: hintText,
            labelText: hintText,
            icon: icon,
            suffix: isPass!
                ? GestureDetector(
                    child: Icon(showPassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onTap: () => showPassword(!showPassword.value),
                  )
                : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Constants.main),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Constants.main),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Constants.main),
            ),
          ),
          cursorColor: Constants.main,
        ));
  }
}
