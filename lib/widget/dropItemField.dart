import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropItemField extends StatelessWidget{
  final List<DropdownMenuItem<String>>? dropdownItems;
  final String? value, hintText, text;
  final onChange;
  final double? width;
  bool withText;

   DropItemField({Key? key, this.dropdownItems, this.value, this.onChange, this.hintText, this.width, this.text, this.withText = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      // color: Colors.white38,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width,
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                  ),
                  validator: (value) => value == null ? hintText ??"Select" : null,
                  value: value,
                  onChanged: onChange,
                  items: dropdownItems),
            ),
            withText
                ? Text(text!,style: TextStyle(fontSize: 22,color: Colors.black54,fontWeight: FontWeight.bold),)
                : Container()
          ],
        ),
      ),
    );
  }

}