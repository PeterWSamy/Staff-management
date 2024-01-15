import 'package:flutter/material.dart';
import 'package:staff/res/colors.dart';

class EmployeeButtons extends StatelessWidget {
  final onEditPressed;
  final onDeletePressed;
  const EmployeeButtons(
      {super.key, required this.onDeletePressed, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          Spacer(),
          InkWell(
            onTap: onDeletePressed,
            child: Icon(Icons.delete, color: StaffColors.darkPurple),
          ),
        ],
      ),
    );
  }
}
