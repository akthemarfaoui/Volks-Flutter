import 'dart:convert';
import "package:http/http.dart" as http;

import 'package:volks_demo/Model/Entity/Comment.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';

class CommentRepository {

  List<Comment> parseComment(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
  }

  Future<int> addComment(String route, Comment comment) async {
    var url = getServerURL(route, []);
    var response = await http.post(url,
        body: jsonEncode(comment), headers: {"Content-Type": "application/json"});

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


  Future<List<Comment>> fetchComments(String route,[dynamic args]) async {
    var url = getServerURL(route, args);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return parseComment(response.body);
    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
  }
  Future<int> getCountComments(String route,[dynamic args]) async {
    var url = getServerURL(route, args);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)[0]["nb"];
    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
  }

}