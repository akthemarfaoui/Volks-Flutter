
import 'package:floor/floor.dart';
import 'package:volks_demo/Model/FloorLocalStorage/Entity/UserLS.dart';

@dao
abstract class UserDao
{

  @Query('SELECT * FROM UserLS')
  Future<List<UserLS>> findAllUsers();

  @Query('SELECT * FROM UserLS WHERE id = :id')
  Stream<UserLS> findUserById(int id);

  @insert
  Future<void> insertUser(UserLS userLS);

  @Query('DELETE FROM UserLS WHERE id = :id')
  Future<void> delete(int id);

  @Query('DELETE FROM UserLS')
  Future<void> deleteAll();

}