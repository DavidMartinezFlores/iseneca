import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iseneca/models/user_local.dart';
import 'package:iseneca/models/user_model.dart';


class UserProvider extends ChangeNotifier
{
  final _dio = Dio();
  final List<UserLocal> userList=[];

  late final userMap;

  void fillUserList()
  {
    userList.addAll(UserModel.getUserList());
    notifyListeners();
  }
  
  fillEmails() async {
    var response = await _dio.get('https://script.google.com/macros/s/AKfycbza-4_cGrNwZtsk1JmIvTDq5KBiZZLj-U5aV1h6E6Zxfd56LiAG2XPLEFOuD4K6bmKT-Q/exec?spreadsheetId=1Qt5sghI2oMo-_ODI1pdDBlFkoiE5orcc0fqIvI6P470&sheet=usuarios');
    // Access the values in the parsed JSON
    
    userMap = jsonDecode(response.data);
  }
}