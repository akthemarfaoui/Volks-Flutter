import 'dart:async';
import 'package:floor/floor.dart';
import 'package:volks_demo/Model/FloorLocalStorage/DAO/UserDao.dart';
import 'package:volks_demo/Model/FloorLocalStorage/Entity/UserLS.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'AppDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [UserLS])
abstract class AppDatabase extends FloorDatabase {

  UserDao get userDao;

}