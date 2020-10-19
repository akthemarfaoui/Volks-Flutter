import 'dart:convert';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import "package:http/http.dart" as http;

class UserRepository {

  List<User> parseUser(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<User> getUser(String route, [dynamic args]) async {
    var url = getServerURL(route, args);
    print(url);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      if (response.contentLength ==
          2) // yaaani l body is not empty (!= []) donc lkina objet
      {
        return null;
      } else {
        return User.fromJson(jsonDecode(response.body)[0]);
      }
    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
    // return compute(parseUser,response.body);
  }

  Future<int> addUser(String route, User user) async {
    var url = getServerURL(route, []);
    var response = await http.post(url,
        body: jsonEncode(user), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
    // return compute(parseUser,response.body);
  }

  Future<int> updateUser(String route,User user) async{

    var url = getServerURL(route, []);

  //print(jsonEncode(user));
    var response = await http.put(url, body: jsonEncode(user), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {

      return response.statusCode;

    } else {

      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());

    }

  }


}
