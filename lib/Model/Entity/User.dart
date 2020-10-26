
import 'package:floor/floor.dart';

@Entity(tableName: 'User')

class User{

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
 String image;
 int number_children_disabilities;
 int number_children;

 User({this.first_name, this.last_name, this.phone_number, this.address, this.partner, this.sexe, this.birth_date, this.job, this.number_children_disabilities, this.number_children, this.id,this.username, this.password, this.email });

 User.AnotherCtor(String Username,String Password,String Sexe,DateTime BirthDate)
 {

  this.username = Username;
  this.password = Password;
  this.sexe = Sexe;
  this.birth_date=BirthDate.toIso8601String();

 }

 User.ImageCtor(String Image)
 {
   this.image=Image;
 }


 Map toJson() => {
   'username': username,
   'password': password,
   'sexe': sexe,
   'birth_date': birth_date,
   'first_name': first_name,
   'last_name': last_name,
   'phone_number': phone_number,
   'address': address,
   'job': job,
 };

factory User.fromJson(Map<String, dynamic> json) {
  return User(

    id: json['id'] as dynamic,
    username: json['username'] as dynamic,
    password: json['password'] as dynamic,
    email: json['email'] as dynamic,
    first_name: json['first_name'] as dynamic,
    last_name: json['last_name'] as dynamic,
    address: json['address'] as dynamic,
    partner: json['partner'] as dynamic,
    phone_number: json['phone_number'] as dynamic,
    sexe: json['sexe'] as dynamic,
    birth_date: json['birth_date'] as dynamic,
    job: json['job'] as dynamic,
    number_children_disabilities: json['number_children_disabilities'] as dynamic,
    number_children: json['number_children'] as dynamic,


  );
}



}

