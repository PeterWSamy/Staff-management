import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:staff/res/colors.dart';
import 'package:staff/ui/login/login_provider.dart';
import 'package:staff/ui/navigation/routers.dart';

class AdminLogutButton extends StatelessWidget {
  const AdminLogutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          Spacer(),
          InkWell(
            onTap: () {
              Provider.of<LoginProvider>(context, listen: false).logout();
              context.go(RouterNames.login);
            },
            child: Icon(Icons.logout, color: StaffColors.darkPurple),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
