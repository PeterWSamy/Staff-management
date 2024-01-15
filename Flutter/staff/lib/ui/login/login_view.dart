import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:staff/res/colors.dart';
import 'package:staff/res/dimensions.dart';
import 'package:staff/ui/login/login_provider.dart';
import 'package:staff/ui/login/login_view_model.dart';
import 'package:staff/ui/navigation/routers.dart';
import 'package:staff/ui/widgets/button.dart';
import 'package:staff/ui/widgets/login_text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../res/images.dart';
import '../../res/strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var vm = LoginViewModel();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              color: StaffColors.lightPurple,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.padding16),
              child: Column(children: [
                const SizedBox(
                  height: 16,
                ),
                Text(Strings.language,
                    style: TextStyle(
                        fontSize: Dimensions.fontSize16,
                        color: StaffColors.loginEnglishColor)),
                const SizedBox(
                  height: 121,
                ),
                Image.asset(
                  Images.staffLogo,
                  width: Dimensions.instgramLogoWidth,
                ),
                const SizedBox(
                  height: 121,
                ),
                LoginTextFieldWidget(
                    hint: Strings.email, controller: emailController),
                const SizedBox(
                  height: 16,
                ),
                LoginTextFieldWidget(
                  hint: Strings.password,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 16,
                ),
                ButtonWidget(
                  name: "login",
                  onPressed: () {
                    if (vm.validateInputs(
                        emailController.text, passwordController.text)) {
                      Provider.of<LoginProvider>(context, listen: false).signin(
                        {
                          "email": emailController.text,
                          "password": passwordController.text
                        },
                      );
                      context.go(RouterNames.loginRedirection);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter email and password"),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
