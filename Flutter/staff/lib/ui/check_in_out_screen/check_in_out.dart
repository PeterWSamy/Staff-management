import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:staff/res/colors.dart';
import 'package:staff/ui/login/login_provider.dart';
import 'package:staff/ui/navigation/routers.dart';
import 'package:staff/ui/widgets/button.dart';

class CheckInOut extends StatelessWidget {
  const CheckInOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      if (provider.checkInStatus == "success") {
        showToast("Check In Success");
        provider.checkInStatus = "";
      } else if (provider.checkInStatus == "fail") {
        showToast("Check In Fail");
        provider.checkInStatus = "";
      }

      if (provider.checkOutStatus == "success") {
        showToast("Check Out Success");
        provider.checkOutStatus = "";
      } else if (provider.checkOutStatus == "fail") {
        showToast("Check Out Fail");
        provider.checkOutStatus = "";
      }
      return Container(
        decoration: BoxDecoration(
          color: StaffColors.lightPurple,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 121, 0, 30),
                  child: ButtonWidget(
                    name: "check In",
                    onPressed: () {
                      provider.checkIn();
                    },
                  ),
                ),
                ButtonWidget(
                  name: "check Out",
                  onPressed: () {
                    provider.checkOut();
                  },
                ),
                Spacer(),
                ButtonWidget(
                  name: "logout",
                  onPressed: () {
                    provider.logout();
                    context.go(RouterNames.login);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: StaffColors.darkPurple,
        textColor: StaffColors.lightPurple,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM);
    print("toast $msg");
  }
}
