import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:staff/ui/home/home_screen.dart';
import 'package:staff/ui/home/home_screen_admin.dart';
import 'package:staff/ui/login/login_provider.dart';
import 'package:staff/ui/login/login_view.dart';

class LoginRedirection extends StatelessWidget {
  const LoginRedirection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      switch (provider.isLogedIn) {
        case 0:
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        case 1:
          if (provider.user!.role == "admin") return const HomeScreenAdmin();
          return const HomeScreen();
        case -1:
          Fluttertoast.showToast(
              msg: provider.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              textColor: Colors.white,
              fontSize: 8.0);
          return LoginScreen();
        default:
          return const Center(child: Text("Error"));
      }
    });
  }
}
