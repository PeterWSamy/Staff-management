import 'package:flutter/material.dart';
import 'package:staff/res/colors.dart';
import 'package:staff/res/dimensions.dart';

class ButtonWidget extends StatelessWidget {
  final name;
  final onPressed;

  const ButtonWidget({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(StaffColors.primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.borderRadius50),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.padding16),
          child: Text(
            name,
            style:
                TextStyle(fontSize: Dimensions.fontSize20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
