import 'package:volks_demo/Utils/HttpConfig.dart';

class Post {
  int id;
  String username;
  String posted_in;
  String description;
  String group_name;
  String position;
  String coord_lat;
  String coord_lng;

  Post({
    this.id,
    this.username,
    this.posted_in,
    this.description,
    this.group_name,
    this.position,
    this.coord_lat,
    this.coord_lng
  });

  Post.AddWithoutPosition(String Username, String Description) {
    this.username = Username;
    this.posted_in =getFormatedDate(DateTime.now()).toString();
    this.description = Description;
  }

  Post.AddWithPosition(String Username,String Description,String coord_lat,String coord_lng,String position)
  {
    this.username = Username;
    this.description = Description;
    this.coord_lng = coord_lng;
    this.coord_lat = coord_lat;
    this.position = position;
    this.posted_in =getFormatedDate(DateTime.now()).toString();
  }

  Map toJson() => {
        'username': username,
        'posted_in': posted_in,
        'description': description,
        'group_name': group_name,
        'position': position,
        'coord_lng': coord_lng,
        'coord_lat': coord_lat,
      };

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as dynamic,
      username: json['username'] as dynamic,
      posted_in: json['posted_in'] as dynamic,
      description: json['description'] as dynamic,
      group_name: json['group_name'] as dynamic,
      position: json['position'] as dynamic,
      coord_lng: json['coord_lng'] as dynamic,
      coord_lat: json['coord_lat'] as dynamic,
    );
  }
}
