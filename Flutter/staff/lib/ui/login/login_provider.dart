import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staff/data/models/user_model.dart';
import 'package:staff/data/models/history_model.dart';
import 'package:staff/domain/GetHttpRequestUseCase.dart';
import 'package:staff/res/api_routes.dart';

class LoginProvider extends ChangeNotifier {
  int isLogedIn = 0;
  double balance = 0;
  User? user;
  String checkInStatus = "";
  String checkOutStatus = "";
  List<HistoryModel>? history;
  String error = "";

  Future<void> signin(Map<String, dynamic> body) async {
    print("is Loged in $isLogedIn");
    try {
      var res =
          await GetHttpRequestUseCase.instance.post(ApiRoutes.postLogin, body);
      print(res.data["data"]);
      user = User.fromJson(res.data["data"]);
      getHistory(12);
      isLogedIn = 1;
    } catch (e) {
      isLogedIn = -1;
      error = e.toString();
      print(e);
    }
    print("is Loged in $isLogedIn");
    notifyListeners();
  }

  Future<void> getHistory(int month) async {
    try {
      var res = await GetHttpRequestUseCase.instance.get(
          ApiRoutes.getGetHistory, {'month': month}, {'email': user!.email});
      print(res.data["data"]);
      history = [];
      balance = 0;
      for (var item in res.data["data"]) {
        history!.add(HistoryModel.fromJson(item));
        balance += item["workHours"] ?? 0;
      }
      balance = (balance * user!.hour).toInt().toDouble();
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future<void> checkIn() async {
    try {
      var res =
          await GetHttpRequestUseCase.instance.post(ApiRoutes.postCheckIn, {
        'email': user!.email,
        'checkInTime':
            DateFormat("yyyy/MM/dd HH:mm:ss").format(DateTime.now()).toString()
      });
      if (res.data["status"] == "success") {
        checkInStatus = "success";
      } else {
        checkInStatus = "fail";
      }
      print(res.data);
    } catch (e) {
      checkInStatus = "fail";
      print(e);
    }
    print("is Loged in $isLogedIn");
    notifyListeners();
  }

  Future<void> checkOut() async {
    try {
      var res =
          await GetHttpRequestUseCase.instance.post(ApiRoutes.postCheckOut, {
        'email': user!.email,
        'checkOutTime': DateFormat("yyyy/MM/dd HH:mm:ss").format(DateTime.now())
      });
      if (res.data["status"] == "success") {
        checkOutStatus = 'success';
      } else {
        checkOutStatus = "fail";
      }
      print(res.data);
    } catch (e) {
      checkOutStatus = "fail";
      print(e);
    }
    notifyListeners();
  }

  void logout() {
    user = null;
    isLogedIn = 0;
    checkInStatus = "";
    checkOutStatus = "";
    history = null;
    error = "";
  }
}




//  "email":"minag8443@gmail.com",
//     "checkInTime" : "2023/01/02 08:10:07"
