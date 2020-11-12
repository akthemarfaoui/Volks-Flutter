import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:volks_demo/Model/Entity/Message.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';

class MessageRepository{

  List<Message> parseMessage(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Message>((json) => Message.fromJson(json)).toList();
  }

  Future<List<Message>> fetchMessages(String route,[dynamic args]) async {
    var url = getServerURL(route,args);
    var response = await http.get(url);

    if (response.statusCode == 200) {

      return parseMessage(response.body);

    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
  }


  Future<List<Message>> fetchChats(String route,[dynamic args]) async {
    var url = getServerURL(route,args);
    var response = await http.get(url);

    if (response.statusCode == 200) {

      return parseMessage(response.body);

    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
  }

  Future<int> addMessage(String route, Message message) async {
    var url = getServerURL(route, []);
    var response = await http.post(url,
        body: jsonEncode(message), headers: {"Content-Type": "application/json"});

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