




import 'package:volks_demo/Model/FloorLocalStorage/Database/AppDatabase.dart';
import 'package:volks_demo/Model/FloorLocalStorage/Entity/UserLS.dart';

class UserLSRepository{

void deleteAll() async
{
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final UserDao = database.userDao;

  UserDao.deleteAll();
}

void insertUser(UserLS userLS) async
{

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final UserDao = database.userDao;
  await UserDao.insertUser(userLS);

}

Future<List<UserLS>> findAll() async
{
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final UserDao = database.userDao;
  List<UserLS> result = await UserDao.findAllUsers();
  return result;
}

}