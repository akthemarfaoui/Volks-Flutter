
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/FloorLocalStorage/Database/AppDatabase.dart';
import 'package:volks_demo/Model/FloorLocalStorage/Entity/UserLS.dart';
import 'package:volks_demo/Views/SignInPage.dart';

void main() {

  runApp(SignInPage());

}



void genDb() async
{

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final UserDao = database.userDao;
  final user = UserLS();

  UserDao.deleteAll();
  await UserDao.insertUser(user);
  List<UserLS> result = await UserDao.findAllUsers();
  print(result.length);

}

