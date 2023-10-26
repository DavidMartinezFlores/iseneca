// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:iseneca/data/local_users.dart';
import 'package:iseneca/models/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final String userName;
    final String userPassword;
    final String center;

    UserModel( {
        required this.userName,
        required this.userPassword,
        required this.center,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json["userName"],
        userPassword: json["userPassword"],
        center: json["center"]
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "userPassword": userPassword,
    };

    static List<User> getUserList()
    {
      List<User> usersList=[];

      for(Map map in localUser)
      {
        usersList.add(User(userName: map["userName"], userPassword: map["userPassword"],center: map["center"]));
      }
      return usersList;
    }
}
