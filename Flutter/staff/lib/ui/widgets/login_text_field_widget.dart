import 'package:staff/res/colors.dart';
import 'package:staff/res/dimensions.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class LoginTextFieldWidget extends StatelessWidget {
  String hint;
  TextEditingController controller;
  LoginTextFieldWidget({Key? key, required this.hint,required this.controller }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hint == "Password" ? true : false,
      decoration: InputDecoration(
        
        filled: true,
        fillColor: StaffColors.loginTextFieldBackground,
        hintText: hint,
        hintStyle: TextStyle(color: StaffColors.loginTextField),
        
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: StaffColors.loginTextField),
          borderRadius: BorderRadius.circular(Dimensions.borderRadius10),
        ),
      ),
    );
  }
}
