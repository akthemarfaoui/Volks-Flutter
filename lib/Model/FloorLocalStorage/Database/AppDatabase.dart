import 'dart:async';
import 'package:floor/floor.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/FloorLocalStorage/DAO/UserDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'AppDatabase.g.dart'; // the generated code will be there

@Database(version: 2, entities: [User])
abstract class AppDatabase extends FloorDatabase {

  UserDao get userDao;

}