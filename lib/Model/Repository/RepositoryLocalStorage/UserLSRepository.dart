import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/FloorLocalStorage/Database/AppDatabase.dart';

class UserLSRepository{

void deleteAll() async
{
  final database = await $FloorAppDatabase.databaseBuilder('app_database2.db').build();
  final UserDao = database.userDao;

  UserDao.deleteAll();
}

void insertUser(User userLS) async
{

  final database = await $FloorAppDatabase.databaseBuilder('app_database2.db').build();
  final UserDao = database.userDao;
  await UserDao.insertUser(userLS);

}

Future<List<User>> findAll() async
{
  final database = await $FloorAppDatabase.databaseBuilder('app_database2.db').build();
  final UserDao = database.userDao;
  List<User> result = await UserDao.findAllUsers();
  return result;
}



}