// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String hint;
  final TextEditingController? myContorrler;
  final TextInputType inputType;
  bool? myObscureText;
  MyInputField({
    Key? key,
    required this.hint,
    this.myContorrler,
    required this.inputType,
    this.myObscureText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: TextFormField(
        validator: (value) {
          if (value != null) {
            if (value.length > 30) {
              return "can't be more then 30 char";
            }
            if (value.length < 4) {
              return "can't be less then 4 char";
            }
            return null;
          }
          return null;
        },
        obscureText: myObscureText == null ? false : true,
        style: TextStyle(fontSize: 18),
        keyboardType: inputType,
        textCapitalization: TextCapitalization.words,
        controller: myContorrler,
        decoration: InputDecoration(
          hintText: hint, //'Name'
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }
}
