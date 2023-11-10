import 'package:flutter/material.dart';
import 'package:iseneca/models/user_local.dart';
import 'package:iseneca/models/user_model.dart';

class UserProvider extends ChangeNotifier
{
  final List<UserLocal> userList=[];

  void fillUserList()
  {
    userList.addAll(UserModel.getUserList());
    notifyListeners();
  }
}