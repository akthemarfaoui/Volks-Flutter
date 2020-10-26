import 'package:floor/floor.dart';

@Entity(tableName: 'followers')
class Followers {
  @PrimaryKey(autoGenerate: true)
  int id;
  String username;
  String following;
  String followOn;
  Followers.forAdding({this.username, this.following});

  Followers({this.id, this.username, this.following, this.followOn});

  Map toJson() => {
        'username': username,
        'following': following,
        'followOn': followOn,
      };

  factory Followers.fromJson(Map<String, dynamic> json) {
    return Followers(
      id: json['id'] as dynamic,
      username: json['username'] as dynamic,
      following: json['following'] as dynamic,
      followOn: json['followOn'] as dynamic,
    );
  }
}
