import 'package:flutter/material.dart';
import 'package:iseneca/models/user.dart';
import 'package:iseneca/models/user_model.dart';

class UserProvider extends ChangeNotifier
{
  final List<User> userList=[];

  void fillUserList()
  {
    userList.addAll(UserModel.getUserList());
    notifyListeners();
  }
}