import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:staff/res/colors.dart';
import 'package:staff/ui/home/admin_provider.dart';
import 'package:staff/ui/login/login_provider.dart';
import 'package:staff/ui/navigation/routers.dart';
import 'package:staff/ui/widgets/admin_logut_button.dart';
import 'package:staff/ui/widgets/button.dart';
import 'package:staff/ui/widgets/employee_buttons.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StaffColors.lightPurple,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: ButtonWidget(
                  name: "Add Employee",
                  onPressed: () {
                    print("add employee");
                    context.go(RouterNames.addUser);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Employees",
                  style: TextStyle(fontSize: 20, color: StaffColors.darkPurple),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<AdminProvider>(context,listen: false).getUsers();
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: StaffColors.darkPurple,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<AdminProvider>(builder: (context, provider, child) {
              if (provider.getAllUsersStatus == "" && provider.users.isEmpty) {
                provider.getUsers();
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.getAllUsersStatus == "fail") {
                return Center(
                  child: Text("Error"),
                );
              } else if (provider.users.isEmpty) {
                return Center(
                  child: Text("No employees"),
                );
              }
      
              return Column(
                children: List<Widget>.generate(provider.users.length, (index) {
                  return ListTile(
                    leading: Icon(Icons.person_outline_outlined,
                        color: StaffColors.darkPurple),
                    title: Text(
                      provider.users[index].name,
                      style: TextStyle(
                          fontSize: 15, color: StaffColors.darkPurple),
                    ),
                    subtitle: Text(
                      provider.users[index].title,
                      style: TextStyle(
                          fontSize: 10, color: StaffColors.darkPurple),
                    ),
                    trailing: Builder(
                      builder: (context) {
                        if(provider.users[index].id == Provider.of<LoginProvider>(context,listen: false).user!.id){
                          return AdminLogutButton();
                        }else{
                          return EmployeeButtons(onDeletePressed: (){
                            provider.deleteUser(provider.users[index].id);
                          }, onEditPressed: (){},);
                        }
                      }
                    ),
                  );
                }),
              );
            })
          ],
        ),
      ),
    );
  }
}
