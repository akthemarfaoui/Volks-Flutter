import 'dart:convert';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import "package:http/http.dart" as http;




class PostRepository {

  List<Post> parsePost(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Future<List<Post>> fetchPosts(String route) async {
    var url = getServerURL(route,[]);
    var response = await http.get(url);

    if (response.statusCode == 200) {

      return parsePost(response.body);

    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
    // return compute(parseUser,response.body);
  }


  Future<Post> getPost(String route, [dynamic args]) async {
    var url = getServerURL(route, args);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      if (response.contentLength ==
          2) // yaaani l body is not empty (!= []) donc lkina objet
      {
        return null;
      } else {
        return Post.fromJson(jsonDecode(response.body)[0]);
      }
    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
    // return compute(parseUser,response.body);
  }

  Future<int> addPost(String route, Post post) async {
    var url = getServerURL(route, []);
    var response = await http.post(url,
        body: jsonEncode(post), headers: {"Content-Type": "application/json"});

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
