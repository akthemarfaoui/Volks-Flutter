import 'dart:convert';
import 'package:volks_demo/Model/Entity/Followers.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import "package:http/http.dart" as http;

class FollowersRepository {
  List<Followers> parseFollowers(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Followers>((json) => Followers.fromJson(json)).toList();
  }

  Future<List<Followers>> fetchFollowers(String route, [dynamic args]) async {
    var url = getServerURL(route, args);
    print(url);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return parseFollowers(response.body);
    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
  }

  Future<String> addFollowers(String route, Followers followers) async {
    var url = getServerURL(route, []);
    var response = await http.post(url,
        body: jsonEncode(followers),
        headers: {"Content-Type": "application/json"});

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

  Future<Followers> getOneFollowers(String route, [dynamic args]) async {
    var url = getServerURL(route, args);
    var response = await http.get(url);
    //print();

    if (response.statusCode == 200) {
      if(jsonDecode(response.body).toString()=="[]")
      {
        return null;
      }else{
        return Followers.fromJson(jsonDecode(response.body)[0]);
      }

    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }




    // return compute(parseUser,response.body);
  }

  Future<String> deleteFollowers(String route, [dynamic args]) async {
    var url = getServerURL(route, args);
    var response = await http.delete(url);
    //print();

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


}
