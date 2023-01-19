import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_test/Model/data_model.dart';

class ThirdScreenProvider with ChangeNotifier {
  final dio = Dio();
  String url = "https://reqres.in/api/users";
  List<UsersModel> _users = [];
  UsersModel? _user;

  List<UsersModel> get getusers => _users;
  UsersModel? get getuser => _user;

  Future<void> setAllUser() async {
    var res = await dio.get(url);
    if (res.statusCode == 200) {
      final List user = res.data["data"];
      _users = user.map((e) => UsersModel.fromJson(e)).toList();
    }
    notifyListeners();
  }

  selectedUser(selectuser) {
    _user = selectuser;
    notifyListeners();
  }
}
