import 'package:flutter/material.dart';
import 'package:untitled17/model/My_User.dart';

class authProviderd extends ChangeNotifier{
  MyUser ?curentUser;

   void updateUser(MyUser newUser)
  {
    curentUser = newUser;
    notifyListeners();
  }
}