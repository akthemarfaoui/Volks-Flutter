import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:volks_demo/Model/Entity/Activity.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';

class ActivityRepository{

  List<Activity> parseActivity(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Activity>((json) => Activity.fromJson(json)).toList();
  }


  Future<List<Activity>> fetchActivities(String route,[dynamic args]) async {
    var url = getServerURL(route,args);
    var response = await http.get(url);

    if (response.statusCode == 200) {

      return parseActivity(response.body);

    } else {
      throw Exception("Thabet ya bhim => status code= " +
          response.statusCode.toString() +
          " URI = " +
          response.request.url.toString());
    }
    // return compute(parseUser,response.body);
  }

  Future<String> addActivity(String route, Activity activity) async {
    var url = getServerURL(route, []);
    var response = await http.post(url,
        body: jsonEncode(activity), headers: {"Content-Type": "application/json"});

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