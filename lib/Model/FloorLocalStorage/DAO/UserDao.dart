
import 'package:floor/floor.dart';
import 'package:volks_demo/Model/Entity/User.dart';

@dao
abstract class UserDao
{

  @Query('SELECT * FROM User')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM User WHERE id = :id')
  Stream<User> findUserById(int id);

  @insert
  Future<void> insertUser(User userLS);

  @Query('DELETE FROM User WHERE id = :id')
  Future<void> delete(int id);

  @Query('DELETE FROM User')
  Future<void> deleteAll();

}