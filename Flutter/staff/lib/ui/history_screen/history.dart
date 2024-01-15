import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff/res/colors.dart';
import 'package:staff/ui/login/login_provider.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StaffColors.lightPurple,
      ),
      child: SingleChildScrollView(
        child: Consumer<LoginProvider>(
          builder: (context, provider, child) {
            if (provider.history == null) {
              return Column(children: [
                SizedBox(height: 200,),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ]);
            }
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.balance_outlined,
                          color: StaffColors.darkPurple),
                      title: Text(
                        "Balance",
                        style: TextStyle(
                            fontSize: 20, color: StaffColors.darkPurple),
                      ),
                      trailing: Text(
                        provider.balance.toString() + " \$",
                        style: TextStyle(
                            fontSize: 20, color: StaffColors.darkPurple),
                      ),
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
                      "History",
                      style: TextStyle(
                          fontSize: 20, color: StaffColors.darkPurple),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        provider.getHistory(DateTime.now().month.toInt());
                      },
                      icon: Icon(Icons.refresh_outlined,
                          color: StaffColors.darkPurple),
                    )
                  ],
                ),
                Column(
                  children: List<Widget>.generate(
                    provider.history!.length,
                    (index) {
                      return ListTile(
                        leading: Icon(Icons.check_circle_outline_outlined,
                            color: StaffColors.darkPurple),
                        title: Text(
                          provider.history![index].checkInTime
                                  .trim()
                                  .split("T")[0] +
                              " " +
                              getWeekDay(DateTime.parse(
                                      provider.history![index].checkInTime)
                                  .weekday),
                          style: TextStyle(
                              fontSize: 15, color: StaffColors.darkPurple),
                        ),
                        subtitle: Text(
                          provider.history![index].checkInTime
                              .trim()
                              .split("T")[1]
                              .split(".")[0],
                          style: TextStyle(
                              fontSize: 12, color: StaffColors.darkPurple),
                        ),
                        trailing: Text(
                          provider.history![index].workHours.toString() +
                              " hours",
                          style: TextStyle(
                              fontSize: 20, color: StaffColors.darkPurple),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String getWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wendesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturaday";
      case 7:
        return "Sunday";
      default:
        return "Monday";
    }
  }
}
