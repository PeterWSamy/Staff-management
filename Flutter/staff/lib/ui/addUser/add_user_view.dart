import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:staff/res/colors.dart';
import 'package:staff/res/dimensions.dart';
import 'package:staff/res/strings.dart';
import 'package:staff/ui/addUser/add_user_viewmodel.dart';
import 'package:staff/ui/home/admin_provider.dart';
import 'package:staff/ui/navigation/routers.dart';
import 'package:staff/ui/widgets/button.dart';
import 'package:staff/ui/widgets/login_text_field_widget.dart';

class AddUser extends StatelessWidget {
  AddUser({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final hourRateController = TextEditingController();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var vm = AddUserViewModel();
    String? roleController = "";
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go(RouterNames.homeScreenAdmin);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Spacer(
            flex: 2,
          ),
          Text(
            "Add User",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: StaffColors.darkPurple,
            ),
          ),
          Spacer(
            flex: 3,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: StaffColors.lightPurple,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.padding16),
              child: Column(children: [
                const SizedBox(
                  height: 100,
                ),
                LoginTextFieldWidget(
                  hint: "name",
                  controller: nameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                LoginTextFieldWidget(
                  hint: Strings.email,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                LoginTextFieldWidget(
                  hint: "title",
                  controller: titleController,
                ),
                const SizedBox(
                  height: 16,
                ),
                LoginTextFieldWidget(
                  hint: "hourly rate",
                  controller: hourRateController,
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  child: DropdownButton(
                      iconSize: 24,
                      elevation: 24,
                      style: TextStyle(color: StaffColors.darkPurple),
                      underline: Container(
                        height: 2,
                        color: StaffColors.darkPurple,
                      ),
                      isExpanded: true,
                      hint: Text("role"),
                      items: [
                        DropdownMenuItem(
                            child: Text(
                              "Admin",
                            ),
                            value: "admin"),
                        DropdownMenuItem(
                            child: Text("Employee"), value: "user"),
                      ],
                      onChanged: (value) {
                        roleController = value;
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<AdminProvider>(builder: (context, provider, child) {
                  if (provider.userAddedStatus == "success") {
                    Fluttertoast.showToast(
                        msg: "User added successfully",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: StaffColors.darkPurple,
                        textColor: StaffColors.lightPurple);
                    provider.userAddedStatus = "";
                    RoutesHandler().pop(context);
                  } else if (provider.userAddedStatus != "") {
                    Fluttertoast.showToast(
                        msg: "Error",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: StaffColors.darkPurple,
                        textColor: StaffColors.lightPurple);
                    provider.userAddedStatus = "";
                  } else if (provider.userAddedStatus == "loading") {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (provider.userAddedStatus == "") {
                  } else {
                    Fluttertoast.showToast(
                        msg: "Error",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: StaffColors.darkPurple,
                        textColor: StaffColors.lightPurple);
                    provider.userAddedStatus = "";
                  }
                  return ButtonWidget(
                    name: "Add",
                    onPressed: () {
                      String msg = vm.checkFormValidation(
                          nameController.text,
                          emailController.text,
                          roleController!,
                          titleController.text,
                          hourRateController.text);
                      if (msg != "") {
                        Fluttertoast.showToast(
                            msg: msg,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: StaffColors.darkPurple,
                            textColor: StaffColors.lightPurple);
                      } else {
                        try {
                          int number = int.parse(hourRateController.text);
                          provider.addUser({
                            "name": nameController.text,
                            "email": emailController.text,
                            "role": roleController!,
                            "title": titleController.text,
                            "hourPrice": number
                          });
                        } catch (e) {
                          print("Error: $e");
                        }
                      }
                    },
                  );
                }),
                const SizedBox(
                  height: 170,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
