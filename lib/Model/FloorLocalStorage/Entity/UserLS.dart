
import 'package:floor/floor.dart';

@Entity(tableName: 'UserLS')
class UserLS{

  @PrimaryKey(autoGenerate: true)
  int id;

  String username;
  String password;
  String email;
  String first_name;
  String last_name;
  int phone_number;
  String address;
  String partner;
  String sexe;
  String birth_date;
  String job;
  int number_children_disabilities;
  int number_children;



}