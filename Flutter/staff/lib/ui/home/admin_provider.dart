import 'package:flutter/material.dart';
import 'package:staff/data/models/user_model.dart';
import 'package:staff/domain/GetHttpRequestUseCase.dart';
import 'package:staff/res/api_routes.dart';

class AdminProvider extends ChangeNotifier {
  String userAddedStatus = "";
  String userDeletedStatus = "";
  String getAllUsersStatus = "";
  List<User> users = [];

  Future<void> getUsers() async {
    try {
      var res = await GetHttpRequestUseCase.instance
          .get(ApiRoutes.getAllUsers, null, null);
      users = [];
      if (res.data["status"] == "success") {
        getAllUsersStatus = "success";
        for(var user in res.data["data"]){
          users.add(User.fromJson(user));
        }
      } else {
        getAllUsersStatus = "fail";
      }

    } catch (e) {
      getAllUsersStatus = "fail";
      print(e);
    }
    notifyListeners();
  }

  Future<void> addUser(Map<String, dynamic> body) async {
    try {
      var res = await GetHttpRequestUseCase.instance
          .post(ApiRoutes.postAddUser, body);
      print(res.data["status"]);
      if (res.data["status"] == "success") {
        userAddedStatus = "success";
        await getUsers();
      } else {
        userAddedStatus = "fail";
      }
    } catch (e) {
      userAddedStatus = "fail";
      print(e);
    }
    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    try {
      var res =
          await GetHttpRequestUseCase.instance.delete(ApiRoutes.deleteUser+"/$id");
      print(res.data["status"]);
      if (res.data["status"] == "success") {
        userDeletedStatus = "success";
        await getUsers();
      } else {
        userDeletedStatus = "fail";
      }
    } catch (e) {
      userDeletedStatus = "fail";
      print(e);
    }
    notifyListeners();
  }
}
