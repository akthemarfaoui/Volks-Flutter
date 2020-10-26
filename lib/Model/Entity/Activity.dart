

class Activity {

int id;
String username;
String actWith;
DateTime actIn;
String type;


Map toJson() => {
  'id': id,
  'username': username,
  'actWith': actWith,
  'actIn': actIn,
  'type': type,
};

Activity({this.id,this.username,this.actWith,this.actIn,this.type});

factory Activity.fromJson(Map<String, dynamic> json) {
  return Activity(
    id: json['id'] as dynamic,
    username: json['username'] as dynamic,
    actWith: json['actWith'] as dynamic,
    actIn: json['actIn'] as dynamic,
    type: json['type'] as dynamic,
  );
}

}